# Nomad Pack: Vaultwarden

![Vaultwarden Repo](https://github.com/dani-garcia/vaultwarden)

This Nomad Pack will install a single instance of the Vaultwarden container image. Visit [VaultWarden project page](https://github.com/dani-garcia/vaultwarden ) for more information. 

## Table of Contents

<!-- TOC -->
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Vaultwarden](#vaultwarden)
    * [Nomad](#nomad)
<!-- TOC -->

## Requirements

- HashiCorp Nomad `1.7.x` or [newer](https://developer.hashicorp.com/nomad/install)
- HashiCorp Nomad Pack `0.1.0` or [newer](https://releases.hashicorp.com/nomad-pack/)

## Pack Usage

### Locally 

```shell
git clone https://github.com/awanaut/nomad-packs.git 
cd nomad-packs
nomad-pack run ./vaultwarden
```

### From Repo

```shell
nomad-pack registry add awanaut github.com/awanaut/nomad-packs
nomad-pack run vaultwarden --registry=awanaut
```
### Custom Variables
==TO DO==
 
### Notes
- All defaults should be sufficient for home or small office use. If your Nomad installation has been customzied you'll need to change a few variables to ensure it is scheduled properly. 
- Currently, this pack only supports docker mounts
- This pack does not include an exhaustive list of all environment variables that are available. Feel free to edit the pack and submit a PR.

## Variables

<!-- Include information on the variables from your pack -->
| Name  | Description   | Default |
| ---------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- | ------- |
| `job_name`| The name to use as the job name which overrides using the pack name | vaultwarden |
| `datacenters` |  A list of datacenters in the region which are eligible for task placement | *
|`region`| The region where jobs will be deployed | global
| `node_pool`| Specify a node pool if needed | default
|`namespace` | Specifiy a namespace. ACL token most likely will be needed if using a namespace | default |
| `tag` | Specify docker tag. Visit project page for exact tags| latest|
| `volume` | Specify either a name which will create a volume mount or a bind path (ie. /path/nomad/apps) which will use a bind mount path to store configuration data. **NOTE**: These are docker mounts NOT Nomad volumes. Ensure [Docker volume mounts are enabled](https://developer.hashicorp.com/nomad/docs/drivers/docker#volumes-1) in your Nomad configuration if using bind mounts. Default is a Volume NOT a bind mount. | data_volume|
|`port`|Define a custom port to be exposed|8080|
| `websocket_enabled` | Enables websocket notifications| true |
| `domain` | External FQDN including http(s):// | https://vaultwarden.mydomain.com |
|`admin_token` | Token for the admin interface, preferably an Argon2 PCH string. Vaultwarden has a built-in generator by calling `vaultwarden hash`. For details see: https://github.com/dani-garcia/vaultwarden/wiki/Enabling-admin-page#secure-the-admin_token. If not set, the admin panel is disabled. **Note** Unlike docker-compose, escape characters are not needed for this Pack.| 
| `sends_allowed`|Controls whether users are allowed to create Bitwarden Sends| true |
|`emergency_access_allowed`| Controls whether users can enable emergency access to their accounts| true |
|`signups_allowed` | Controls if new users can register| true|
| `web_vault_enabled` | Web vault enabled or disabled | true|
| `smtp_host` | SMTP Host for sending signups and notifications| |
| `smtp_from` |Address to send notifications from| | 
|`smtp_security` |Enable a secure connection | starttls|
| `smtp_port` | Ports 587 (submission) and 25 (smtp) are standard without encryption and with encryption via STARTTLS (Explicit TLS). Port 465 (submissions) is used for encrypted submission (Implicit TLS). | 587 |
| `smtp_username` | SMTP username| |
| `smtp_password` | SMTP password| |

