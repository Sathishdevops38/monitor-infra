resource "helm_release" "loki" {
  name       = "loki"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki-stack"
  namespace  = "monitoring"
  values = [<<EOF
promtail:
  enabled: true # Promtail is the agent that "tails" the log files on your nodes
EOF
  ]
}