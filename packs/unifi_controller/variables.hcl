variable "job_name" {
  description = "The name to use as the job name which overrides using the pack name"
  type        = string
  default = "unifi_controller"
}

variable "node_pool" {
  description = "Node Pool"
  type        = string
  default     = "default"
}
variable "region" {
  description = "The region where jobs will be deployed"
  type        = string
  default = "global"
}

variable "datacenters" {
  description = "A list of datacenters in the region which are eligible for task placement"
  type        = list(string)
  default     = ["dc1"]
}

variable "service_provider" {
  description = "Choose either Nomad service discovery or Consul"
  type = string
  default = "nomad"
}

variable "version" {
  description = "Docker image version"
  type = string
  default = "7"
}

variable "volume" {
  description = "Specify either a volume name or a bind mount path."
  type = string
  default = "data_volume"
}

variable "namespace" {
  description = "Specify a custom namespace"
  type = string
  default = ""
}

variable "PUID" {
  description = "PUID to use for container"
  type = number
  default = 1000
}

variable "PGID" {
  description = "PGID to use for container"
  type = number
  default = 1000
}

variable "TZ" {
  description = "Timezone"
  type = string
  default = "America/New_York"
}
