resource "helm_release" "grafana" {
  name       = "grafana"
  namespace  = "monitoring"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  version    = "7.3.10"

  values = [<<EOF
adminUser: admin
adminPassword: password

service:
  type: LoadBalancer

persistence:
  enabled: true
  size: 20Gi
  # type: sts  # Uncomment if you want to use a StatefulSet for better stability

datasources:
  datasources.yaml:
    apiVersion: 1
    datasources:
      - name: Prometheus
        type: prometheus
        url: http://kube-prometheus-stack-prometheus.monitoring:9090
        access: proxy
        isDefault: true
EOF
  ]
}
