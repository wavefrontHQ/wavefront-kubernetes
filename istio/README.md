# Re-deploy Istio's zipkin service on Kubernetes

From your kubenetes cluster run the below steps:

## 1. Delete existing zipkin service
```
kubectl delete svc zipkin -n istio-system
```

## 2. Deploy new zipkin service
```
kubectl apply -f zipkin-svc-redirect.yml
```
