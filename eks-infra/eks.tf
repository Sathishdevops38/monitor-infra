module "eks" {
  source                         = "terraform-aws-modules/eks/aws"
  version                        = "20.8.3"
  cluster_name                   = "monitoring-eks"
  cluster_version                = "1.34"
  create_kms_key                 = false
  cluster_endpoint_public_access = true
  cluster_encryption_config      = {}
  # 1. Automatically gives YOU (the terraform runner) access
  enable_cluster_creator_admin_permissions = true

  # 2. Gives access to specific OTHER people/roles
  access_entries = {
    developer_access = {
      principal_arn = "arn:aws:iam::441700732169:user/monitor"
      policy_associations = {
        admin = {
          policy_arn   = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = { type = "cluster" }
        }
      }
    }
  }
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  eks_managed_node_groups = {
    monitoring = {
      instance_types = ["m7i-flex.large"]
      desired_size   = 2
      min_size       = 2
      max_size       = 4
    }
  }
}