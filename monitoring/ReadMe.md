### Command to run
## kubectl patch storageclass gp2 -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
## kubectl apply -f https://raw.githubusercontent.com/GoogleCloudPlatform/microservices-demo/main/release/kubernetes-manifests.yaml -n boutique

# Deploy this in monitoring namespace 

apiVersion: monitoring.coreos.com/v1
kind: PodMonitor
metadata:
  name: boutique-monitor
  namespace: monitoring
  labels:
    release: kube-prometheus-stack # MUST match your Helm release name
spec:
  selector:
    matchLabels:
      app: frontend
      app: adservice
      app: artservice
      app: checkoutservice
      app: currencyservice
      app: emailservice
      app: loadgenerator
      app: paymentservice
      app: productcatalogservice
      app: recommendationservice
      app: redis-cart
      app: shippingservice
  podMetricsEndpoints:
  - port: http
    path: /metrics
  namespaceSelector:
    matchNames:
    - boutique


* Kubernetes Monitoring (Modern)	12740	The most popular current replacement for 315. It handles the API changes in K8s 1.25+ perfectly.
* Prometheus / Kubernetes (Full)	19105	Highly Recommended. This is a modern, high-performance dashboard specifically designed for the kube-prometheus-stack features.
* K8s Cluster Summary	14205	A direct fork of 315 that was fixed specifically for modern K8s metric names.    