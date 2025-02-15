# # Terraform Workspaces
# variable "workspace_env" {
#   default = terraform.workspace
# }

# # variable "workspace_env" {
# #   description = "The environment (e.g., Dev, staging, Production)"
# #   type        = string
# # }

# # Define common tags per environment
# variable "common_tags" {
#   description = "Common tags per environment"
#   type        = map(map(string))
#   default = {
#     Dev  = { Project = "MyProject-Dev", Environment = "Dev", ManagedBy = "Terraform" }
#     Prod = { Project = "MyProject-Prod", Environment = "Prod", ManagedBy = "Terraform" }
#   }
# }


# # # I removed the ' EnableNAT'. actually it wont accept this map . because these things are in boolean
# # default = {
# #   Dev  = { Project = "MyProject-Dev", Environment = "Dev", ManagedBy = "Terraform", EnableNAT = "false" }
# #   Prod = { Project = "MyProject-Prod", Environment = "Prod", ManagedBy = "Terraform", EnableNAT = "true" }
# # }


# variable "EnableNAT" {
#   type = map(bool)

#   default = {
#     "EnableNAT" = false
#   }
# }



# # Define resource names per environment
# variable "resource_names" {
#   description = "Resource names per environment"
#   type        = map(map(string))
#   default = {
#     Dev = {
#       vpc            = "Dev-VPC"
#       public_subnet  = "Dev-Public-Subnet"
#       private_subnet = "Dev-Private-Subnet"
#       internet_gw    = "Dev-Internet-Gateway"
#       # nat_gateway    = "Dev-NAT-Gateway"
#       public_rt  = "Dev-Public-Route-Table"
#       private_rt = "Dev-Private-Route-Table"
#     }
#     Prod = {
#       vpc            = "Prod-VPC"
#       public_subnet  = "Prod-Public-Subnet"
#       private_subnet = "Prod-Private-Subnet"
#       internet_gw    = "Prod-Internet-Gateway"
#       # nat_gateway    = "Prod-NAT-Gateway"
#       public_rt  = "Prod-Public-Route-Table"
#       private_rt = "Prod-Private-Route-Table"
#     }
#   }
# }



# Terraform Workspaces
variable "workspace_env" {
  # default = terraform.workspace
}

# Define common tags per environment
variable "common_tags" {
  description = "Common tags per environment"
  type        = map(map(string))
  default = {
    Dev  = { Project = "MyProject-Dev", Environment = "Dev", ManagedBy = "Terraform" }
    Prod = { Project = "MyProject-Prod", Environment = "Prod", ManagedBy = "Terraform" }
  }
}

# Define NAT enablement per environment
variable "EnableNAT" {
  description = "Enable NAT Gateway per environment"
  type        = map(bool)
  default = {
    Dev  = false
    Prod = true
  }
}


# Define resource names per environment
variable "resource_names" {
  description = "Resource names per environment"
  type        = map(map(string))
  default = {
    Dev = {
      vpc            = "Dev-VPC"
      public_subnet  = "Dev-Public-Subnet"
      private_subnet = "Dev-Private-Subnet"
      internet_gw    = "Dev-Internet-Gateway"
      nat_gateway    = "Dev-NAT-Gateway"
      public_rt      = "Dev-Public-Route-Table"
      private_rt     = "Dev-Private-Route-Table"
    }
    Prod = {
      vpc            = "Prod-VPC"
      public_subnet  = "Prod-Public-Subnet"
      private_subnet = "Prod-Private-Subnet"
      internet_gw    = "Prod-Internet-Gateway"
      nat_gateway    = "Prod-NAT-Gateway"
      public_rt      = "Prod-Public-Route-Table"
      private_rt     = "Prod-Private-Route-Table"
    }
  }
}


