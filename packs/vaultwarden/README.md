# unifi_controller

<!-- Include a brief description of your pack -->

This Nomad Pack will install a single instance of the Vault Warden docker image. Visit (VaultWarden project page)[https://github.com/dani-garcia/vaultwarden] for more information. This pack does not include an exhaustive list of all environment variables that are available.

## Pack Usage

<!-- Include information about how to use your pack -->
All defaults should be sufficient for home or small office use. If your Nomad installation has been customzied you'll need to change a few variables to ensure it is scheduled properly. 

Currently, this pack only supports volumes so ensure you pin the controller to the same node.

## Nomad or Consul Service Discovery

This pack allows you to choose between either using the built in native service discovery (default) or using consul. If using consul, ensure Consul has been installed and integrated with your Nomad cluster. See [https://developer.hashicorp.com/nomad/docs/configuration/consul] for more information.

## Variables

<!-- Include information on the variables from your pack -->

- `job_name` (string: vaultwarden) - The name to use as the job name which overrides using
  the pack name
- `datacenters` (list of strings: ["dc1"]) - A list of datacenters in the region which are eligible for task placement
- `region` (string: global) - The region where jobs will be deployed
- `node_pool` (string: default) - Specify a node pool if needed
- `namespace` (string: default) - Specifiy a namespace. ACL's most likely will be needed if using a namespace
- `service_provider` (string: nomad) - Valid options are either 'nomad' or 'consul'
- `version` (string: default) - Specify docker tag. Visit project page for exact tags
- `volume` (string: data_volume) - Specify either a name which will create a volume mount or a bind path (ie. /path/nomad/apps) which will use a bind mount path to store configuration data
- `websocket_enabled` (bool: true) - Enables websocket notifications
- `domain` (string) - External FQDN
- `admin_token` (string) - Token for the admin interface, preferably an Argon2 PCH string. Vaultwarden has a built-in generator by calling `vaultwarden hash`. For details see: https://github.com/dani-garcia/vaultwarden/wiki/Enabling-admin-page#secure-the-admin_token. If not set, the admin panel is disabled. **Note** Unlike docker-compose, escape characters are not needed for this Pack.
- `sends_allowed` (bool: true) - Controls whether users are allowed to create Bitwarden Sends
- `emergency_access_allowed` (bool: true) - Controls whether users can enable emergency access to their accounts
- `signups_allowed` (bool: true) - Controls if new users can register
- `web_vault_enabled` (bool: true) - Web vault enabled or disabled
- `smtp_host` (string) - SMTP Host for sending signups and notifications
- `smtp_from` (string) - Address to send notifications from
- `smtp_security` (string: starttls) - Enable a secure connection
- `smtp_port` (number: 587) - Ports 587 (submission) and 25 (smtp) are standard without encryption and with encryption via STARTTLS (Explicit TLS). Port 465 (submissions) is used for encrypted submission (Implicit TLS).
- `smtp_username` (string) - SMTP username
- `smtp_password` (string) - SMTP password

