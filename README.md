# wavefront-kubernetes
Kubernetes definitions and templates for Wavefront monitoring

## Wavefront Proxy (required)
1. Deploy a [Wavefront Proxy](wavefront-proxy/)
	- Update `YOUR_CLUSTER` and `YOUR_API_TOKEN` according to your instance of Wavefront

## Kubernetes system metrics
1. Deploy [Heapster](heapster/) to get standard Kubernetes metrics
	- Update `CLUSTER_NAME` for your cluster
1. Deploy [kube-state-metrics](kube-state-metrics/) to get state metrics
	- Update `CLUSTER_NAME` for your cluser

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


### Usage: Prometheus scraping over a Kubernetes service
You may have want to monitor all individual endpoints (pods) associated with a given Kubernetes service that emit Prometheus metrics.
Because the name, and number of endpoints can change this needs to be dynamic. The Telegraf Prometheus plugin, can be used in this situation
with the following configuration setup.
- Create a new [Headless service](https://kubernetes.io/docs/concepts/services-networking/service/#headless-services) in Kubernetes where you expose your Prometheus http-metrics port
	- `clusterIP` needs to be set to `None`
	- `type` should not be specified
	- make sure your service selector will select the required pods
	- you only need to expose the Prometheus http-metrics port to be scraped

Sample service definition:
```yaml
kind: Service
apiVersion: v1
metadata:
  name: my-service-metrics
spec:
  selector:
    app: MyApp
  clusterIp: None
  ports:
  - name: http-metrics
    port: 8080
```

