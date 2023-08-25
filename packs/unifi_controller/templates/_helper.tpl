[[ define "service_provider" -]]
[[- if eq .unifi_controller.service_provider "consul" -]]
      service {
        provider = "consul"
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
[[- else if eq .unifi_controller.service_provider "nomad" -]]
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
[[- end -]]
[[- end ]]

// allow nomad-pack to set the job name

[[ define "job_name" ]]
[[- if eq .unifi_controller.job_name "" -]]
[[- .nomad_pack.pack.name | quote -]]
[[- else -]]
[[- .unifi_controller.job_name | quote -]]
[[- end ]]
[[- end ]]




