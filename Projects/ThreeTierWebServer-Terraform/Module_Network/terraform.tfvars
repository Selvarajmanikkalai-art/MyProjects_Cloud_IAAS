workspace_env = "Prod"

common_tags = {
  Dev  = { Project = "MyProject-Dev", Environment = "Dev", ManagedBy = "Terraform" }
  Prod = { Project = "MyProject-Prod", Environment = "Prod", ManagedBy = "Terraform" }
}

EnableNAT = {
  Dev  = false
  Prod = true
}

resource_names = {
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
