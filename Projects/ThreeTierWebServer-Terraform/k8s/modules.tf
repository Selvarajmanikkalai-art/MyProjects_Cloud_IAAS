module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.24.1" # Use latest version

  cluster_name    = "my-eks-cluster"
  cluster_version = "1.28"

  vpc_id     = data.aws_vpc.selected_vpc.id
  subnet_ids = data.aws_subnets.subnets.ids  # This line fetches the subnet IDs correctly

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  eks_managed_node_groups = {
    default = {
      min_size     = 1
      max_size     = 3
      desired_size = 2
      instance_types = ["t3.medium"]
    }
  }
}

module "vpc" {
  source         = "git::https://github.com/Selvarajmanikkalai-art/Projects_check.git"
  workspace_env  = "Dev"
}


module "eks-kubeconfig" {
  source     = "hyperbadger/eks-kubeconfig/aws"
  version    = "1.0.0"

  depends_on = [ module.eks ]
  cluster_id = module.eks.cluster_id
}
