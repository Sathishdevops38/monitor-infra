data "terraform_remote_state" "eks" {
  backend = "s3" # Change from "local" to "s3"

  config = {
    bucket = "terraform-backend-86"                       # The name of your S3 bucket
    key    = "roboshop-monitor-infras" # The exact key (path) used in Folder 02
    region = "us-west-2"                                  # Your AWS region
  }
}

data "aws_eks_cluster_auth" "this" {
  # This pulls the name from your Folder 02 outputs
  name = data.terraform_remote_state.eks.outputs.cluster_name
}