
provider "aws" {
  region = "us-east-1"
}

provider "kubernetes" {
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.Demo.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.Demo_Auth.token
}