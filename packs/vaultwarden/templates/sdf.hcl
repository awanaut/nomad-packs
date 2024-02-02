job vaultwarden {
  region      = global
  datacenters = ["dc1"]
  namespace   = default
  node_pool   = default
  type        = "service"

  update {
    max_parallel = 1
    stagger      = "30s"
    auto_revert  = true
  }

  reschedule {
    attempts       = 15
    interval       = "1h"
    delay          = "30s"
    delay_function = "constant"
    max_delay      = "120s"
    unlimited      = false
  }

  group "vaultwarden" {
    count = 1

    network {



      port "http" {
        to     = 80
        static =
      }

    }
    restart {
      attempts = 2
      interval = "30m"
      delay    = "15s"
      mode     = "fail"
    }

    task "server" {
      driver = docker



      config {
        image = "docker.io/vaultwarden/server:v1.1.3"
        ports = ["http"]


        mount {
          type     = "bind"
          source   = "/volume1/nvme/nomad/test-volume"
          target   = "/data"
          readonly = false
        }



        resources {
          cpu    = 500
          cores  = null
          memory = 512
        }

        env {
          WEBSOCKET_ENABLED        = true
          DOMAIN                   = ""
          ADMIN_TOKEN              = "adfgsrthw45456"
          SENDS_ALLOWED            = true
          EMERGENCY_ACCESS_ALLOWED = true
          SIGNUPS_ALLOWED          = true
          WEB_VAULT_ENABLED        = true
          SMTP_HOST                = "test.com"
          SMTP_FROM                = "jdf"
          SMTP_SECURITY            = "starttls"
          SMTP_PORT                = "587"
          SMTP_USERNAME            = "sadf"
          SMTP_PASSWORD            = "dsfgsd"
        }
        service {
          provider = "nomad"
          name     = "vaultwarden"
          port     = "http"

          check {
            name     = "Health Check"
            type     = "http"
            port     = "http"
            interval = "10s"
            timeout  = "2s"
            path     = "/alive"
            check_restart {
              grace = "90s"
              limit = 3
            }
          }
        }
      }
    }
  }
}