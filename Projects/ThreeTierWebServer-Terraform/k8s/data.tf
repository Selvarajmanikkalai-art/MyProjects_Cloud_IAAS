# data "aws_availability_zone" "available_availability_zone" {}

data "aws_availability_zone" "available_aws_availability_zone" {
  name = "us-east-1a"  # Specify a single zone name
}

data "aws_eks_cluster" "Demo" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "Demo_Auth" {
  name = module.eks.cluster_id
}

data "aws_vpc" "selected_vpc" {
  id = module.vpc.vpc_id
}

# Correct usage of filter to get subnets for the selected VPC
data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected_vpc.id]
  }
}
