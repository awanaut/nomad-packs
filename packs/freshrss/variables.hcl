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

variable "port" {
  description = "Define a custom port to be exposed. Remove default if you want to use a random port."
  type = number
  default = 80
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
variable "pinned_host" {
  type = string
  description = "Pinned Host"
}
variable "service_tags" {
  type = list(string)
  description = "List of service tags"
}

variable "timezone" {
  type = string
  description = "Timezone"
  default = "America/New_York"
}

variable "cron_min" {
  type = string
  description = "Define minutes for the built-in cron job to automatically refresh feeds (see github repo for more advanced options)"
}

variable "data_path" {
  type = string
  description = "Define the path to the data directory"
}

variable "freshrss_env" {
  type = string
  description = "(default is production) Enables additional development information if set to development (increases the level of logging and ensures that errors are displayed) (see github repo for more development options)"
  default = "production"
}

variable "syslog" {
  type = string
  description = "(default is On) Copy all the logs to syslog"
  default = "on"
}

variable "stderr" {
  type = string
  description = "(default is On) Copy all the logs to stderr"
  default = "on"
}

variable "listen" {
  type = number
  description = "Modifies the internal Apache port"
  default = 80
}

variable "freshrss_install" {
  type = string
  description = "automatically pass arguments to command line cli/do-install.php (for advanced users; see example in Docker Compose section on github repo). Only executed at the very first run (so far), so if you make any change, you need to delete your freshrss service, freshrss_data volume, before running again."
}

variable "freshrss_user" {
  type = string
  description = "automatically pass arguments to command line cli/create-user.php (for advanced users; see example in Docker Compose section on github repo). Only executed at the very first run (so far), so if you make any change, you need to delete your freshrss service, freshrss_data volume, before running again."
}