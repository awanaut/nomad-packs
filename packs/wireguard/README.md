# Nomad Pack: Wireguard-easy

![Wireguard Repo](https://github.com/wg-easy/wg-easy)

This Nomad Pack will install a single instance of the Wireguard container image. Visit [Wireguard project page](https://github.com/wg-easy/wg-easy) for more information. 

## Table of Contents

<!-- TOC -->
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Secrets Prequisites](#secrets-prereqs)
    * [Wireguard](#Wireguard)
    * [Nomad](#nomad)
  * [Variables](#variables)
<!-- TOC -->

## Requirements

- HashiCorp Nomad `1.7.x` or [newer](https://developer.hashicorp.com/nomad/install)
- HashiCorp Nomad Pack `0.1.0` or [newer](https://releases.hashicorp.com/nomad-pack/)
- Password secret stored within Nomad. See [usage](#usage) below.

## Pack Usage

### Secrets Prereqs

```nomad var put nomad/jobs/wireguard password=somepassword```

**NOTE**: Change nomad/jobs/**Wireguard** to the name of the job if you chose a custom job name.


### Locally 

```shell
git clone https://github.com/awanaut/nomad-packs.git 
cd nomad-packs
```
Edit nomadvars.hcl to your liking.

```shell
nomad-pack run ./wireguard -f ./nomadvars.hcl
```

### From Repo

If needed, create nomadvars.hcl and set variables to your liking. Refer to [Variables](#variables) section.
```shell
nomad-pack registry add awanaut github.com/awanaut/nomad-packs
nomad-pack run wireguard -f ./nomadvars.hcl --registry=awanaut 
```
 


## Variables

<!-- Include information on the variables from your pack -->
| Name  | Description   | Default |
| ---------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- | ------- |
| `job_name`| The name to use as the job name which overrides using the pack name | Wireguard |
| `datacenters` |  A list of datacenters in the region which are eligible for task placement | *
|`region`| The region where jobs will be deployed | global
| `node_pool`| Specify a node pool if needed | default
|`namespace` | Specifiy a namespace. ACL token most likely will be needed if using a namespace | default |
| `runtime` | Container runtime. Docker or Podman. | docker |
| `tag` | Specify docker tag. Visit project page for exact tags| latest|
| `volume` | Specify either a name which will create a volume mount or a bind path (ie. /path/nomad/apps) which will use a bind mount path to store configuration data. **NOTE**: These are docker mounts NOT Nomad volumes. Ensure [Docker volume mounts are enabled](https://developer.hashicorp.com/nomad/docs/drivers/docker#volumes-1) in your Nomad configuration if using bind mounts. Default is a Volume NOT a bind mount. | data_volume|
|`gui-port`|Define a custom port to be exposed for the gui|51821|
| `udp-port` | Define a custom port to be exposed for Wireguard tunnel endpoint|51820|
| `timezone` | Timezone | America/New_York |
| `wg_host` | The public hostname of your VPN server. | |
| `dns` | The DNS server to use for the VPN. | 1.1.1.1 |
| `language` | Language of web portal | en |
| `pinned_host` | Hostname or IP of Nomad client node to pin job to. See [note](#pinned-host) below for more details | |
| `nomad_task_resources` | CPU and Memory to allocate to Wireguard | CPU 500, Mem 512 |
| `service_tags` | Tags to assign to the Wireguard service. Useful for something like Traefik. | None |

## Notes
- All defaults should be sufficient for home or small office use. If your Nomad installation has been customzied you'll need to change a few variables to ensure it is scheduled properly. 
- Currently, this pack only supports docker mounts

### Pinned host
If you do not have a mechanism to dynamically update your NAT rules on router, then it is recommended to pin your wireguard endpoint to a specific Nomad client node to ensure Nomad doesn't schedule wireguard allocation on another node during job restarts. 