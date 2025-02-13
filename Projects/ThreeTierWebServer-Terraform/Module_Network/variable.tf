# Terraform Workspaces
variable "workspace_env" {
  default = terraform.workspace
}

# Define common tags per environment
variable "common_tags" {
  description = "Common tags per environment"
  type        = map(map(string))
  default = {
    dev  = { Project = "MyProject-Dev", Environment = "Dev", ManagedBy = "Terraform", EnableNAT = "false" }
    prod = { Project = "MyProject-Prod", Environment = "Prod", ManagedBy = "Terraform", EnableNAT = "true" }
  }
}

# Define resource names per environment
variable "resource_names" {
  description = "Resource names per environment"
  type        = map(map(string))
  default = {
    dev = {
      vpc           = "Dev-VPC"
      public_subnet = "Dev-Public-Subnet"
      private_subnet = "Dev-Private-Subnet"
      internet_gw   = "Dev-Internet-Gateway"
      nat_gateway   = "Dev-NAT-Gateway"
      public_rt     = "Dev-Public-Route-Table"
      private_rt    = "Dev-Private-Route-Table"
    }
    prod = {
      vpc           = "Prod-VPC"
      public_subnet = "Prod-Public-Subnet"
      private_subnet = "Prod-Private-Subnet"
      internet_gw   = "Prod-Internet-Gateway"
      nat_gateway   = "Prod-NAT-Gateway"
      public_rt     = "Prod-Public-Route-Table"
      private_rt    = "Prod-Private-Route-Table"
    }
  }
}
