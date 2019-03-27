# Deploy Wavefront Kubernetes Collector with Auto Discovery rules

From your Kubernetes cluster run the below steps:

## 1. Deploy a ConfigMap of the Discovery rules
```
kubectl apply -f deploy/appmesh-discovery-config.yaml
```

## 2. Deploy the Wavefront Kubernetes Collector with the above Discovery configuration:

```
kubectl apply -f deploy/4-collector-deployment.yaml
```

Note: Refer to the [github repo](https://github.com/wavefrontHQ/wavefront-kubernetes-collector/tree/master/deploy/kubernetes) for the latest collector deployment.
