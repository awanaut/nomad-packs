variable "job_name" {
  description = "The name to use as the job name which overrides using the pack name"
  type        = string
  default = "synology_csi"
}

variable "node_pool" {
  description = "Node Pool"
  type        = string
  default     = "all"
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
  description = "Namespace to deploy the job to"
  type = string
  default = "default"
}

variable "tag" {
  description = "Container image tag"
  type = string
  default = "v1.1.3"
}

variable "runtime" {
  description = "Container runtime to use. Docker or Podman"
  type = string
  default = "docker"
}

variable "host" {
  description = "Endpoint of Synology host API"
  type = string
}

variable "https" {
  description = "Enable HTTPS"
  type = bool
  default = false
}

variable "username" {
  description = "Username for Synology"
  type = string
}

variable "password" {
  description = "Password for Synology"
  type = string
}

variable "location" {
  description = "Location to mount CSI volumes"
  type = string
}

variable "port" {
  description = "Synology http(s) port"
  type = number
  default = 5000
}
