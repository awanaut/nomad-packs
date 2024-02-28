# Nomad Pack: FreshRSS

![FreshRSS Repo](https://github.com/FreshRSS/FreshRSS)

This Nomad Pack will install a single instance of the FreshRSS container image. Visit [FreshRSS project page](https://github.com/FreshRSS/FreshRSS) for more information. 

## Table of Contents

<!-- TOC -->
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [FreshRSS](#FreshRSS)
    * [Nomad](#nomad)
  * [Variables](#variables)
  * [Notes](#notes)
<!-- TOC -->

## Requirements

- HashiCorp Nomad `1.7.x` or [newer](https://developer.hashicorp.com/nomad/install)
- HashiCorp Nomad Pack `0.1.0` or [newer](https://releases.hashicorp.com/nomad-pack/)
- If using bind mounts, ensure /pathtomount/freshrss/extensions exists.

## Pack Usage

### Locally 

```shell
git clone https://github.com/awanaut/nomad-packs.git 
cd nomad-packs
```
Edit nomadvars.hcl to your liking.

```shell
nomad-pack run ./FreshRSS -f ./nomadvars.hcl
```

### From Repo

If needed, create nomadvars.hcl and set variables to your liking. Refer to [Variables](#variables) section.
```shell
nomad-pack registry add awanaut github.com/awanaut/nomad-packs
nomad-pack run FreshRSS -f ./nomadvars.hcl --registry=awanaut 
```
 
## Variables

<!-- Include information on the variables from your pack -->
| Name  | Description   | Default |
| ----------------- | --- | ------- |
| `job_name`| The name to use as the job name which overrides using the pack name | FreshRSS |
| `datacenters` |  A list of datacenters in the region which are eligible for task placement | *
|`region`| The region where jobs will be deployed | global
| `node_pool`| Specify a node pool if needed | default
|`namespace` | Specifiy a namespace. ACL token most likely will be needed if using a namespace | default |
| `runtime` | Container runtime. Docker or Podman. | docker |
| `tag` | Specify docker tag. Visit project page for exact tags| latest|
| `volume` | Specify either a name which will create a volume mount or a bind path (ie. /path/nomad/apps) which will use a bind mount path to store configuration data. **NOTE**: These are docker mounts NOT Nomad volumes. Ensure [Docker volume mounts are enabled](https://developer.hashicorp.com/nomad/docs/drivers/docker#volumes-1) in your Nomad configuration if using bind mounts. Default is a Volume NOT a bind mount. | data_volume|
|`port`|Define a custom port to be exposed for the gui. Leave blank for dynamic port allocation | |
| `timezone` | Timezone | America/New_York |
| `pinned_host` | Specify either a Nomad client name or IP address to create a constraint for FreshRSS | null |
| `nomad_task_resources` | CPU and Memory to allocate to FreshRSS | CPU 500, Mem 512 |
| `service_tags` | Tags to assign to the FreshRSS service. Useful for something like Traefik. | None |
| `cron_min` | Define minutes for the built-in cron job to automatically refresh feeds (see github repo for more advanced options) | disabled |
| `data_path` | defined by ./constants.local.php or ./constants.php. Defines the path for writeable data. | null |
| `freshrss_env` | Enables additional development information if set to development (increases the level of logging and ensures that errors are displayed) (see github repo for more development options) | production |
| `syslog` | Copy all the logs to syslog | on |
| `stderr` | Copy all the logs to stderr | on |
| `listen` | Modifies the internal Apache port | 80 |
| `freshrss_install` | automatically pass arguments to command line cli/do-install.php (for advanced users; see example in Docker Compose section on github repo). Only executed at the very first run (so far), so if you make any change, you need to delete your freshrss service, freshrss_data volume, before running again. | null |
| `freshrss_user` | automatically pass arguments to command line cli/create-user.php (for advanced users; see example in Docker Compose section on github repo). Only executed at the very first run (so far), so if you make any change, you need to delete your freshrss service, freshrss_data volume, before running again. | null |


## Notes
- All Nomad variable defaults should be sufficient for home or small office use. If your Nomad installation has been customzied you'll need to change a few variables to ensure it is scheduled properly. 
- Currently, this pack only supports docker mounts

