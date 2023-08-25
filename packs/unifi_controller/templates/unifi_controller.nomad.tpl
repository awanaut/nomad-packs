job [[ .unifi_controller.job_name ]] {
  region = [[ .unifi_controller.region | quote ]]
  datacenters = [[ .unifi_controller.datacenters | toStringList ]]
  namespace = [[ .unifi_controller.namespace | quote ]]
  type = "service"

  reschedule {
      attempts       = 15
      interval       = "1h"
      delay          = "30s"
      delay_function = "constant"
      max_delay      = "120s"
      unlimited      = false
  }

  group "unifi_controller" {
    count = 1

    network {
      port "http" {
        static = 8443
        to     = 8443
      }
      port "comms" {
        static = 8080
        to     = 8080
      }
      port "stun" {
        static = 3478
        to     = 3478
      }
      port "discovery" {
        static = 10001
        to     = 10001
      }
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
        image = "jacobalberty/unifi:v[[ .unifi_controller.version ]]"
        ports = ["http", "stun", "discovery", "comms"]
        init = true
        [[ if regexMatch "^\\/.*" .unifi_controller.volume]]
        mount {
          type     = "bind"
          source   = [[ .unifi_controller.volume | quote ]]
          target   = "/unifi"
          readonly = false
        }
        [[ else ]]
        mount {
          type     = "volume"
          source   = [[ .unifi_controller.volume | quote ]]
          target   = "/unifi"
          readonly = false
        }
      [[ end ]]
      }

      env {
        PUID = [[ .unifi_controller.PUID ]]
        PGID = [[ .unifi_controller.PGID ]]
        TZ   = [[ .unifi_controller.TZ | quote ]]
        UNIFI_STDOUT = true
      }
    [[ template "service_provider" . ]]
    }
  }
}
