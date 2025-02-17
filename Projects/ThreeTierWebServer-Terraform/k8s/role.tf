# Define the trust policy for the EKS role
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions   = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]  # EKS Service
    }
  }
}

# Create the IAM Role for EKS
resource "aws_iam_role" "eks_role" {
  name               = "eks-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

# Attach the AmazonEKSClusterPolicy to the IAM Role
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# Attach the AmazonEKSServicePolicy to the IAM Role
resource "aws_iam_role_policy_attachment" "eks_service_policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

# Attach the AmazonEC2ContainerRegistryReadOnly policy for pulling images
resource "aws_iam_role_policy_attachment" "eks_ecr_policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# Attach the CloudWatch policy for EKS logging
resource "aws_iam_role_policy_attachment" "eks_cloudwatch_policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

# Optional: If you are using managed node groups, attach node policies
resource "aws_iam_role_policy_attachment" "eks_node_policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# Attach VPC Full Access for EKS networking
resource "aws_iam_role_policy_attachment" "eks_vpc_policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}

# Define the worker node policy
resource "aws_iam_role_policy" "eks_worker_node_policy" {
  name   = "eks-worker-node-policy"
  role   = aws_iam_role.eks_role.id
  policy = data.aws_iam_policy_document.eks_worker_node_policy.json
}

# Worker node policy definition
data "aws_iam_policy_document" "eks_worker_node_policy" {
  statement {
    actions   = [
      "ec2:DescribeInstances",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeVpcs",
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface"
    ]
    resources = ["*"]
  }
}

# Optionally attach another policy using aws_iam_role_policy
resource "aws_iam_role_policy" "eks_role_policy" {
  name   = "eks-role-policy"
  role   = aws_iam_role.eks_role.id
  policy = data.aws_iam_policy_document.eks_policy.json
}

# Define the additional policy
data "aws_iam_policy_document" "eks_policy" {
  statement {
    actions   = ["ec2:DescribeInstances", "ec2:DescribeSecurityGroups"]
    resources = ["*"]
  }
}
