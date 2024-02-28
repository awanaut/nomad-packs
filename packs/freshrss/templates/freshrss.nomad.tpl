job "[[ var "job_name" . ]]" {
  region = "[[ var "region" . ]]"
  datacenters = [[ var "datacenters" . | toStringList ]]
  namespace = "[[ var "namespace" . ]]"
  node_pool = "[[ var "node_pool" . ]]"
  type = "service"
  [[ template "pinned_hosts" . ]]
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

  group "wireguard" {
    count = 1

    [[ template "port" .]]
    
    restart {
      attempts = 2
      interval = "30m"
      delay = "15s"
      mode = "fail"
    }

    task "wireguard" {
      driver = "[[ var "runtime" . ]]"

      resources {
        [[- $resources := var "nomad_task_resources" . ]]
        cpu        = [[ $resources.cpu ]]
        memory     = [[ $resources.memory ]]
      }

      env {
        TZ = "[[ var "timezone" . ]]"
        CRON_MIN   = "[[ var "cron_min" . ]]"
        DATA_PATH = "[[ var "data_path" . ]]"
        FRESHRSS_ENV = "[[ var "freshrss_env" . ]]"
        COPY_LOG_TO_SYSLOG = "[[ var "syslog" . ]]"
        COPY_SYSLOG_TO_STDERR = "[[ var "stderr" . ]]"
        LISTEN = [[ var "listen" . | toString ]] 
        FRESHRSS_INSTALL = "[[ var "freshrss_install" . ]]"
        FRESHRSS_USER = "[[ var "freshrss_user" . ]]"
      }

      config {
          image = "freshrss/freshrss:[[ var "tag" . ]]"
          ports = ["http"]

        [[ if var "volume" . | regexMatch "^/.*$" ]]
        mount {
          type     = "bind"
          source   = "[[ var "volume" . ]]"
          target   = "/var/www/FreshRSS/data"
          readonly = false
        }
        mount {
          type     = "bind"
          source   = "[[ var "volume" . ]]"
          target   = "/var/www/FreshRSS/extensions"
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
      service {
        name     = "[[ var "job_name" . ]]"
        port     = "gui"
        provider = "nomad"
        [[ template "service_tags" . ]]
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
