# wavefront-kubernetes
Kubernetes definitions and templates for Wavefront monitoring

## Wavefront Proxy (required)
1. Deploy a [Wavefront Proxy](wavefront-proxy/)
	- Update `YOUR_CLUSTER` and `YOUR_API_TOKEN` according to your instance of Wavefront

## Kubernetes system metrics
1. Deploy [Heapster](heapster/) to get standard Kubernetes metrics
1. Deploy [kube-state-metrics](kube-state-metrics/) to get state metrics

## Pod monitoring

### Config Map
Config Maps allow for easy management and standardization of monitoring configuration and settings for any application and service.
Some sample config maps are provided, and can be expanded upon. The sample deployment definitions for monitoring will reference these
config maps, which are all Telegraf plugin configuration snippets.
Sample [Telegraf Config Maps](telegraf-config-maps/)

### Usage: Sidecar container
Use the [Telegraf Sidecar container template](telegraf-sidecar/) to add Telegraf as a sidecar to your existing pod definitions
- Change references to `APPLICATION` to match your application name
- Optionally update the `METRIC_SOURCE_NAME` environment variable to specify a metric source (default is to use Node name)
- Update the config map reference to match the approrpriate deployed config map
- `:alpine` tag for the image can also be used (other version tags also supported)


### Usage: Standalone pod
When sidecar monitoring is not practical, use the standard [Telegraf Deployment template](telegraf/) to monitor the service. 
Prometheus endpoints can be scraped using this method.
- Change references to `APPLICATION` to match your application name
- Optionally update the `METRIC_SOURCE_NAME` environment variable to specify a metric source (default is to use Node name)
- Update the config map reference to match the approrpriate deployed config map
- `:alpine` tag for the image can also be used (other version tags also supported)

