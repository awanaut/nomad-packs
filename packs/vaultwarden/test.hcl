job "vaultwarden" {
  region      = "global"
  datacenters = ["dc1"]
  namespace   = "default"
  type        = "service"

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
        static = 80
        to     = 80
      }
    }

    restart {
      attempts = 2
      interval = "30m"
      delay    = "15s"
      mode     = "fail"
    }

    task "server" {
      driver = "docker"

      config {
        image = "vaultwarden/server:latest"
        ports = ["http"]

        mount {
          type     = "volume"
          source   = "data_volume"
          target   = "/unifi"
          readonly = false
        }
      }

      env {
        WEBSOCKET_ENABLED        = true
        DOMAIN                   = "blah.com"
        ADMIN_TOKEN              = "adfgsrthw45456"
        SENDS_ALLOWED            = true
        EMERGENCY_ACCESS_ALLOWED = true
        SIGNUPS_ALLOWED          = true
        WEB_VAULT_ENABLED        = true
        SMTP_HOST                = "test.com"
        SMTP_FROM                = "jdf"
        SMTP_SECURITY            = "starttls"
        SMTP_PORT                = 587
        SMTP_USERNAME            = "sadf"
        SMTP_PASSWORD            = "dsfgsd"
      }

      service {
        provider = "nomad"
        name     = "unifi-controller"
        port     = "http"

        check {
          name     = "Health Check"
          type     = "tcp"
          port     = "http"
          interval = "10s"
          timeout  = "2s"

          check_restart {
            grace = "90s"
            limit = 3
          }
        }
      }
    }
  }
}