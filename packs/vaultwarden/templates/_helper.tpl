[[ define "engine" ]]
[[- if eq .vaultwarden.engine "docker" -]]
driver = "docker"
[[- else if eq .vaultwarden.engine "podman" -]]
driver = "podman"
[[- end -]]
[[ end ]]

[[ define "service_provider" -]]
[[- if eq .vaultwarden.service_provider "consul" -]]
      service {
        provider = "consul"
        name     = "vaultwarden"
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
[[- else if eq .vaultwarden.service_provider "nomad" -]]
      service {
        provider = "nomad"
        name     = "vaultwarden"
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
[[- if eq .vaultwarden.job_name "" -]]
[[- .nomad_pack.pack.name | quote -]]
[[- else -]]
[[- .vaultwarden.job_name | quote -]]
[[- end ]]
[[- end ]]




