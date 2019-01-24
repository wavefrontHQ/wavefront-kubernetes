# Re-direct traces in Istio to Wavefront

From your Kubernetes cluster run the below steps:

## 1. Delete existing zipkin service
```
kubectl delete svc zipkin -n istio-system
```

## 2. Deploy new zipkin service
```
kubectl apply -f zipkin-svc-redirect.yml
```
