job [[ .vaultwarden.job_name | quote ]] {
  region = [[ .vaultwarden.region | quote ]]
  datacenters = [[ .vaultwarden.datacenters | toStringList ]]
  namespace = [[ .vaultwarden.namespace | quote ]]
  node_pool = [[ .vaultwarden.node_pool | quote ]]
  type = "service"

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
      [[ if empty .vaultwarden.port ]]
        port "http" {
          to     = 80
        }
        [[ else ]]
        port "http" {
          to = 80
          static = [[ .vaultwarden.port ]]
        }
        [[ end ]]
    }
    restart {
      attempts = 2
      interval = "30m"
      delay = "15s"
      mode = "fail"
    }

    task "server" {
      driver = "docker"

      config {
        image = "vaultwarden/server:[[ .vaultwarden.version ]]"
        ports = ["http"]
        [[ if regexMatch "^\\/.*" .vaultwarden.volume]]
        mount {
          type     = "bind"
          source   = [[ .vaultwarden.volume | quote ]]
          target   = "/data"
          readonly = false
        }
        [[ else ]]
        mount {
          type     = "volume"
          source   = [[ .vaultwarden.volume | quote ]]
          target   = "/data"
          readonly = false
        }
      [[ end ]]
      }

      env {
        WEBSOCKET_ENABLED = [[ .vaultwarden.websocket_enabled ]]
        DOMAIN = [[ .vaultwarden.domain | quote ]]
        ADMIN_TOKEN = [[ .vaultwarden.admin_token | quote ]]
        SENDS_ALLOWED = [[ .vaultwarden.sends_allowed ]]
        EMERGENCY_ACCESS_ALLOWED = [[ .vaultwarden.emergency_access_allowed ]]
        SIGNUPS_ALLOWED = [[ .vaultwarden.signups_allowed ]]
        WEB_VAULT_ENABLED = [[ .vaultwarden.web_vault_enabled ]]
        SMTP_HOST = [[ .vaultwarden.smtp_host | quote ]]
        SMTP_FROM = [[ .vaultwarden.smtp_from | quote ]]
        SMTP_SECURITY = [[ .vaultwarden.smtp_security | quote ]]
        SMTP_PORT = [[ .vaultwarden.smtp_port ]]
        SMTP_USERNAME = [[ .vaultwarden.smtp_username | quote ]]
        SMTP_PASSWORD = [[ .vaultwarden.smtp_password | quote ]]
      }
    [[ template "service_provider" . ]]
    }
  }
}
