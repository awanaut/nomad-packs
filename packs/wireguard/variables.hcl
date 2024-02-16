variable "job_name" {
  description = "The name to use as the job name which overrides using the pack name"
  type        = string
  default = "wireguard"
}

variable "node_pool" {
  description = "Node Pool"
  type        = string
  default     = "default"
}
variable "region" {
  description = "The region where jobs will be deployed"
  type        = string
  default     = "global"
}

variable "datacenters" {
  description = "A list of datacenters in the region which are eligible for task placement"
  type        = list(string)
  default     = ["*"]
}

variable "namespace" {
  type = string
  default = "default"
}

variable "tag" {
  description = "Container image tag"
  type = string
  default = "latest"
}

variable "runtime" {
  description = "Container runtime to use. Docker or Podman"
  type = string
  default = "docker"
}

variable "version" {
  description = "Docker image version"
  type = string
  default = "latest"
}

variable "udp-port" {
  description = "Define a custom port to be exposed. Remove default if you want to use a random port."
  type = number
  default = 51820
}
variable "gui-port" {
  description = "Define a custom port to be exposed. Remove default if you want to use a random port."
  type = number
  default = 51821
}
variable "volume" {
  description = "Specify either a volume name or a bind mount path."
  type = string
  default = "data_volume"
}

variable "nomad_task_resources" {
  type = object({
    cpu        = number
    memory     = number
    memory_max = number
  })

  description = "Resource Limits for the Task."

  default = {
    # Tasks can ask for `cpu` or `cores`, not both.
    # value in MHz
    cpu = 500

    # value in MB
    memory = 512

    # value in MB
    # see https://developer.hashicorp.com/nomad/docs/job-specification/resources#memory-oversubscription
    memory_max = 1024
  }
}

variable "service_tags" {
  type = list(string)
  description = "List of service tags"
}

variable "password" {
  type = string
  description = "Password for admin ui"
  default = "changeme"
}

variable "timezone" {
  type = string
  description = "Timezone"
  default = "America/New_York"
}

variable "wg_host" {
  type = string
  description = "The public hostname of your VPN server."
  default = "vpn.myserver.com"
}

variable "dns" {
  type = string
  description = "The DNS server to use for the VPN."
  default = "1.1.1.1"
}

variable "language" {
  type = string
  description = "Language"
  default = "en"
}

variable "pinned_host" {
  type = string
  description = "Pinned Host"
  default = "vm1"
}

variable "env" {
  type = map(string)
  description = "Environment variables"
  default = {
    Test1 = "test1"
    Test = "test"
  }
}