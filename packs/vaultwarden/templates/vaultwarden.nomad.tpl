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
      [[ if var "port" . ]]
      port "http" {
        to = 80
        static = [[ var "port" . ]]
       }
      [[ else ]]
      port "http" {
       to = 80
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
      driver = "[[ var "runtime" . ]]"

      resources {
        [[- $resources := var "nomad_task_resources" . ]]
        cpu        = [[ $resources.cpu ]]
        memory     = [[ $resources.memory ]]
      }
      template {
        data = <<EOH
        ADMIN_TOKEN = "{{ with nomadVar "nomad/jobs/[[ var "job_name" . ]]" }}{{ .admin_token }}{{ end }}"
        EOH
        env = true
        destination = "secrets/secrets.env"
      }
      env {
        WEBSOCKET_ENABLED = [[ var "websocket_enabled" . ]]
        DOMAIN = "[[ var "domain" . ]]"
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
        tags = [[ var "service_tags" . | toStringList ]] 
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
    task "vw-backup" {
      driver = "docker"
      config {
        image = "bruceforce/vaultwarden-backup"
        [[ if var "volume" . | regexMatch "^/.*$" ]]
        mount {
          type     = "bind"
          source   = "/volume1/nvme/nomad/vaultwarden"
          target   = "/data"
          readonly = false
        }
        mount {
          type     = "bind"
          source   = "/volume1/nvme/nomad/vaultwarden/backups"
          target   = "/backups"
          readonly = false
        }
        mount {
          type     = "bind"
          source   = "/volume1/nvme/nomad/vaultwarden/backups/logs"
          target   = "/logs"
          readonly = false
        }
        [[ else ]]
        mount {
          type     = "volume"
          source   = "[[ var "volume" . ]]"
          target   = "/data"
          readonly = false
        }
        mount {
          type     = "volume"
          source   = "[[ var "volume" . ]]"
          target   = "/backups"
          readonly = false
        }
        mount {
          type     = "volume"
          source   = "[[ var "volume" . ]]"
          target   = "/logs"
          readonly = false
        }
      [[ end ]]

      }
      template {
        data = <<EOH
        ENCRYPTION_PASSWORD = "{{ with nomadVar "nomad/jobs/[[ var "job_name" . ]]" }}{{ .encryption_pw }}{{ end }}"
        EOH
        env = true
        destination = "secrets/secrets.env"
      }
      env {
        BACKUP_DIR = "/backups"
        LOG_DIR    = "/logs"
        # EVERY DAY @ 5am
        CRON_TIME              = "0 5 * * *"
        DELETE_AFTER           = "30"
        TIMESTAMP              = true
        UID                    = 0 # enter user that has docker permission
        GID                    = 0 # enter group ID for docker
        BACKUP_ADD_DATABASE    = true
        BACKUP_ADD_ATTACHMENTS = true
        BACKUP_ADD_CONFIG_JSON = true
        BACKUP_ADD_ICON_CACHE  = true
        BACKUP_ADD_RSA_KEY     = true
        LOG_LEVEL              = "INFO"
        BACKUP_ON_STARTUP      = true
        TZ= "America/New_York"
      }
    }
  }
}
