common_tags = {
  Project     = "Ecommerce-App"
  Environment = "Prod"
  ManagedBy   = "Terraform"
  EnableNAT   = "true"  # Change to "false" to disable NAT
}

resource_names = {
  vpc             = "Ecommerce-VPC"
  public_subnet   = "Ecommerce-Public-Subnet"
  private_subnet  = "Ecommerce-Private-Subnet"
  internet_gw     = "Ecommerce-Internet-Gateway"
  nat_gateway     = "Ecommerce-NAT-Gateway"
  public_rt       = "Ecommerce-Public-Route-Table"
  private_rt      = "Ecommerce-Private-Route-Table"
}


//
//To Disable NAT

//Set "EnableNAT" = "false" in terraform.tfvars and re-run terraform apply.
//Terraform will remove NAT Gateway and keep the private subnet truly private.