job [[ var "job_name" . | quote ]] {
  datacenters = [[ var "datacenters" . | toStringList ]]
  namespace   = [[ var "namespace" . | quote ]]
  [[ template "region" . ]]
  node_pool = [[ var "node_pool" . | quote ]]

  type        = "system" 

  group "controller" {
    task "plugin" {
      driver = [[ var "runtime" . | quote ]]
      config {
        image        = "docker.io/synology/synology-csi:[[ var "tag" .]]"
        privileged   = true
        network_mode = "host"
          mount {
          type     = "bind"
          source   = "/"
          target   = "/host"
          readonly = false
        }
          mount {
          type     = "bind"
          source   = "local/csi.yaml"
          target   = "/etc/csi.yaml"
          readonly = true
        }

        args = [
          "--endpoint",
          "unix://csi/csi.sock",
          "--client-info",
          "/etc/csi.yaml"
        ]
      }
      template {
        data        = <<EOH
---
clients:
  - host: [[ var "host" . ]]
    port: [[ var "port" . ]]
    https: [[ var "https" . ]]
    username: [[ var "username" . ]]
    password: [[ var "password" . ]]
    location: [[ var "location" . ]]
EOH
        destination = "local/csi.yaml"
      }
      csi_plugin {
        id        = "synology"
        type      = "monolith"
        mount_dir = "/csi"
      }

      resources {
        cpu    = 500
        memory = 256
      }
    }
  }
}
