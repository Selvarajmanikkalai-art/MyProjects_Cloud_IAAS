# Variables
variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default = {
    Project     = "My-Project"
    Environment = "Dev"
    ManagedBy   = "Terraform"
    EnableNAT   = "true"
  }
}

variable "resource_names" {
  description = "Resource names"
  type        = map(string)
  default = {
    vpc             = "My-VPC"
    public_subnet   = "Public-Subnet"
    private_subnet  = "Private-Subnet"
    internet_gw     = "My-Internet-Gateway"
    nat_gateway     = "My-NAT-Gateway"
    public_rt       = "Public-Route-Table"
    private_rt      = "Private-Route-Table"
  }
}