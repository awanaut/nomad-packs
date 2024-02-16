variable "job_name" {
  description = "The name to use as the job name which overrides using the pack name"
  type        = string
  default = "vaultwarden"
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

variable "volume" {
  description = "Specify either a volume name or a bind mount path."
  type = string
  default = "data_volume"
}

variable "websocket_enabled" {
  description = "Enables websocket notifications"
  type = bool
  default = true
}

variable "domain" {
  description = "External FQDN"
  type = string
  default = "https://vaultwarden.mydomain.com"
}

variable "admin_token" {
  description = "Token for the admin interface"
  type = string
}

variable "sends_allowed" {
  description = "Controls whether users are allowed to create Bitwarden Sends."
  type = bool
  default = true
}

variable "emergency_access_allowed" {
  description = "Controls whether users can enable emergency access to their accounts."
  type = bool
  default = true
}

variable "signups_allowed" {
  description = "Controls if new users can register"
  type = bool
  default = true
}

variable "web_vault_enabled" {
  description = "Web vault enabled or disabled"
  type = bool
  default = true
}

variable "smtp_host" {
  description = "SMTP host"
  type = string
  default = ""
}

variable "smtp_from" {
  description = "Address to send notifications from"
  type = string
  default = ""
}


variable "smtp_security" {
  description = "Enable a secure connection. Default is starttls"
  type = string
  default = "starttls"
}

variable "smtp_port" {
  description = "Ports 587 (submission) and 25 (smtp) are standard without encryption and with encryption via STARTTLS (Explicit TLS). Port 465 (submissions) is used for encrypted submission (Implicit TLS)."
  type = string
  default = "587"
}

variable "smtp_username" {
  description = "SMTP Username"
  type = string
  default = ""
}

variable "smtp_password" {
  description = "SMTP Password"
  type = string
  default = ""
}

variable "port" {
  description = "Define a custom port to be exposed. Remove default if you want to use a random port."
  type = number
  default = 8080
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