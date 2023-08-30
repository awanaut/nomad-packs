# unifi_controller

<!-- Include a brief description of your pack -->

This Nomad Pack will install a single instance of the Unifi Controller docker image.

## Pack Usage

<!-- Include information about how to use your pack -->
All defaults should be sufficient for home or small office use. If your Nomad installation has been customzied you'll need to change a few variables to ensure it is scheduled properly. 

Currently, this pack only supports volumes so ensure you pin the controller to the same node.

## Nomad or Consul Service Discovery

This pack allows you to choose between either using the built in native service discovery (default) or using consul. If using consul, ensure Consul has been installed and integrated with your Nomad cluster. See [https://developer.hashicorp.com/nomad/docs/configuration/consul] for more information.

## Variables

<!-- Include information on the variables from your pack -->

- `job_name` (string: unifi_controller) - The name to use as the job name. Defaults to pack name.
- `datacenters` (list of strings: ["dc1"]) - A list of datacenters in the region which are eligible for task placement
- `region` (string: global) - The region where jobs will be deployed
- `node_pool` (string: default) - Specify a node pool if needed
- `namespace` (string: default) - Specifiy a namespace. ACL token most likely will be needed if using a namespace
- `service_provider` (string: nomad) - Service discovery provider. Valid options are either 'nomad' or 'consul'
- `engine` (string: docker) - Container engine to use. Docker or Podman
- `volume` (string: data_volume) - Specify either a name which will create a volume mount or a bind path (ie. /path/nomad/apps) which will use a bind mount path to store configuration data. **NOTE**: These are docker mounts NOT Nomad volumes. Ensure [Docker volume mounts are enabled](https://developer.hashicorp.com/nomad/docs/drivers/docker#volumes-1) in your Nomad configuration if using bind mounts.
- `PUID` (number: 1000) - PUID to use for container
- `PGID` (number: 1000) - PGID to use for container
- `TZ` (string: America/New_York) - Timezone 

