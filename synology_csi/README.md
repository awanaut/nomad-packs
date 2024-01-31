# Nomad Pack: Synology CSI Driver

![Synology CSI Driver Repo](https://github.com/SynologyOpenSource/synology-csi)

## Table of Contents

<!-- TOC -->
* [Nomad Pack: (HCP) Boundary Worker](#nomad-pack-hcp-boundary-worker)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Application](#application)
    * [Nomad](#nomad)
  * [Troubleshooting](#troubleshooting)
  * [License](#license)
<!-- TOC -->

## Requirements

- DSM 7.0+. Refer to [official Synology CSI repo](https://github.com/SynologyOpenSource/synology-csi) for additional details.
- HashiCorp Nomad `1.7.x` or [newer](https://developer.hashicorp.com/nomad/install)
- HashiCorp Nomad Pack `0.1.0` or [newer](https://releases.hashicorp.com/nomad-pack/)
- Nomad Task Driver(s) for [`Docker`](https://developer.hashicorp.com/nomad/docs/drivers/docker) or [`Podman`](https://developer.hashicorp.com/nomad/plugins/drivers/podman)


## Usage

This pack will deploy the CSI driver as a `system` job across all datacenters and node pools. Feel free to change these variables to match your environment.

The `synology_csi` Pack can be run with a local fileset (commonly used when developing the Pack), or via the [@workloads Nomad Pack Registry](https://github.com/workloads/nomad-pack-registry). <-- change to personal repo or synology

A Pack available _locally_ may be run like so:

```shell
nomad-pack run ./synology_csi
```

#CHANGE TO PERSONAL OR SYNOLOGY REPO
A Pack available via the [@workloads Nomad Pack Registry](https://github.com/workloads/nomad-pack-registry) may be run like so:

```shell
# add the Pack Registry
nomad-pack registry add workloads github.com/workloads/nomad-pack-registry

# run the Pack
nomad-pack run boundary_worker --registry=workloads
```

<!-- BEGIN_PACK_DOCS -->

### Application

This section describes Synology-specific configuration.

| Name                                     | Description                                                                                                                            | Default |
| ---------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- | ------- |
| tag | Container image tag |   v1.1.3 | 
| host | Synology Hostname or IP | |
| port     | Synology http(s) port | 5000 |
| https | Enable https |  false |
| username | Synology username | |
| password | Synology Password |  |
| location | volume location to mount LUN's |   |
 

### Nomad

This section describes Nomad-specific configuration.

| Name                              | Description                                        | Default |
| --------------------------------- | -------------------------------------------------- | ------- |
| datacenters             | Eligible Datacenters for the Job.                  | `["*"]` |
| job_name                    | Name for the Job.                                  | `"synology_csi"` |
| namespace               | Namespace for the Job.                             | `"default"` |
| region                  | Region for the Job.                                | `"global"` |
| runtime                | Docker or Podman                       | `"docker"` |
| nomad_task_resources              | Resource Limits for the Task.                      | `{"cores":null,"cpu":500,"memory":512,"memory_max":1024}` |
| node_pool                       |  Node Pool for the Job |  `"all"` |


## Troubleshooting

If you run into the error: `Error response from daemon: path /volume1/somepath is mounted on /volume1 but it is not a shared mount`

Run the following from shell: `sudo mount --make-shared /volume1/` (Change your volume to match the error)

You may need to create a scheduled task on start up to run this command since this does not persist through reboots.


## License

Licensed under the Apache License, Version 2.0 (the "License").

You may download a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

See the License for the specific language governing permissions and limitations under the License.
