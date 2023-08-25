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
  default     = ["dc1"]
}

variable "namespace" {
  type = string
  default = "default"
}

variable "service_provider" {
  description = "Choose either Nomad service discovery or Consul"
  type = string
  default = "nomad"
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
}

variable "admin_token" {
  description = "Token for the admin interface, preferably an Argon2 PCH string"
  type = string
  default = ""
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
