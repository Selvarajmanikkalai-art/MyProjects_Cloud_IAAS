locals {
  cluster_name = "eks_Demo_cluster"
}

resource "local_file" "kubeconfig" {
  content  = module.eks-kubeconfig.kubeconfig
  filename = "kubeconfig_${local.cluster_name}"
}




