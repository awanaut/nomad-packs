job "[[ var "job_name" . ]]" {
  region = "[[ var "region" . ]]"
  datacenters = [[ var "datacenters" . | toStringList ]]
  namespace = "[[ var "namespace" . ]]"
  node_pool = "[[ var "node_pool" . ]]"
  type = "service"

  update {
    max_parallel = 1
    stagger      = "30s"
    auto_revert = true
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
      [[ template "port" .]]
    }
    restart {
      attempts = 2
      interval = "30m"
      delay = "15s"
      mode = "fail"
    }

    task "server" {
      driver = "[[ var "runtime" . ]]"

      resources {
        [[- $resources := var "nomad_task_resources" . ]]
        cpu        = [[ $resources.cpu ]]
        memory     = [[ $resources.memory ]]
      }

      env {
        WEBSOCKET_ENABLED = [[ var "websocket_enabled" . ]]
        DOMAIN = "[[ var "domain" . ]]"
        ADMIN_TOKEN = "[[ var "admin_token" . ]]"
        SENDS_ALLOWED = [[ var "sends_allowed" . ]]
        EMERGENCY_ACCESS_ALLOWED = [[ var "emergency_access_allowed" . ]]
        SIGNUPS_ALLOWED = [[ var "signups_allowed" . ]]
        WEB_VAULT_ENABLED = [[ var "web_vault_enabled" . ]]
        SMTP_HOST = "[[ var "smtp_host" . ]]"
        SMTP_FROM = "[[ var "smtp_from" . ]]"
        SMTP_SECURITY = "[[ var "smtp_security" . ]]"
        SMTP_PORT = "[[ var "smtp_port" . ]]"
        SMTP_USERNAME = "[[ var "smtp_username" . ]]"
        SMTP_PASSWORD = "[[ var "smtp_password" . ]]"
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
          path = "/alive"
          check_restart {
            grace = "90s"
            limit = 3
          }
        }
      }
      config {
        image = "docker.io/vaultwarden/server:[[ var "tag" . ]]"
        ports = ["http"]

        [[ if var "volume" . | regexMatch "^/.*$" ]]
        mount {
          type     = "bind"
          source   = "[[ var "volume" . ]]"
          target   = "/data"
          readonly = false
        }
        [[ else ]]
        mount {
          type     = "volume"
          source   = "[[ var "volume" . ]]"
          target   = "/data"
          readonly = false
        }
      [[ end ]]


     
      }
    }
  }
}
