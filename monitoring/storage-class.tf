# 1. Create the gp3 Storage Class (Faster & 20% Cheaper)
resource "kubernetes_storage_class" "gp3" {
  metadata {
    name = "gp3"
  }
  storage_provisioner    = "ebs.csi.aws.com"
  reclaim_policy         = "Delete"
  allow_volume_expansion = true
  volume_binding_mode    = "WaitForFirstConsumer"

  parameters = {
    type      = "gp3"
    encrypted = "true"
  }
}

# 2. Create/Manage the gp2 Storage Class
resource "kubernetes_storage_class" "gp2" {
  metadata {
    name = "gp2"
    annotations = {
      # This makes gp2 the DEFAULT for the entire cluster
      "storageclass.kubernetes.io/is-default-class" = "true"
    }
  }
  storage_provisioner    = "kubernetes.io/aws-ebs"
  reclaim_policy         = "Delete"
  allow_volume_expansion = true
  volume_binding_mode    = "WaitForFirstConsumer"

  parameters = {
    type      = "gp2"
    encrypted = "true"
  }
}

# 3. Force-disable any other defaults (Safety Measure)
# Use this if you want to ensure ONLY gp2 is the default
resource "kubernetes_annotations" "disable_other_defaults" {
  api_version = "storage.k8s.io/v1"
  kind        = "StorageClass"
  force       = true

  metadata {
    name = "gp3" # Ensure gp3 is NOT the default
  }

  annotations = {
    "storageclass.kubernetes.io/is-default-class" = "false"
  }

  depends_on = [kubernetes_storage_class.gp3]
}