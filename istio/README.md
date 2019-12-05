# Re-direct traces in Istio to Wavefront

Note that you will require your wavefront proxy to be deployed in the default namespace for the below steps to work as-is. 
If its in a different namespace, then modify zipkin-svc-redirect.yml accordingly to reflect the custom namespace.

From your Kubernetes cluster run the below steps:

## 1. Delete existing zipkin service
```
kubectl delete svc zipkin -n istio-system
```

## 2. Deploy new zipkin service
```
kubectl apply -f zipkin-svc-redirect.yml
```
