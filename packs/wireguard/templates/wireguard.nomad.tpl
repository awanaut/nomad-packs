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

    network {
      port "wg-udp" {
        to = [[ var "udp-port" .]]
        static = [[ var "udp-port" .]]
      }
      port "gui" {
        to = [[ var "gui-port" .]]
        static = [[ var "gui-port" .]]
      }
    }
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
        WG_HOST = "[[ var "wg_host" . ]]"
        TZ = "[[ var "timezone" . ]]"
        LANG = "[[ var "language" . ]]"
        WG_DEFAULT_DNS = "[[ var "dns" . ]]"
      }
      template {
        data = <<EOH
        PASSWORD = "{{ with nomadVar "nomad/jobs/[[ var "job_name" . ]]" }}{{ .password }}{{ end }}"
        EOH
        env = true
        destination = "secrets/secrets.env"
      }
      config {
          image = "ghcr.io/wg-easy/wg-easy"
          ports = ["wg-udp", "gui"]
          cap_add = ["NET_ADMIN"]
        	sysctl = {
            "net.ipv4.conf.all.src_valid_mark" = "1",
            "net.ipv4.ip_forward" = "1" 
          }

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
      service {
        name     = "[[ var "job_name" . ]]"
        port     = "gui"
        provider = "nomad"
        [[ template "service_tags" . ]]
        check {
          name     = "Health Check"
          type     = "tcp"
          port     = "gui"
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
