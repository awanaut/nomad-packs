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
  default     = "global"
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
