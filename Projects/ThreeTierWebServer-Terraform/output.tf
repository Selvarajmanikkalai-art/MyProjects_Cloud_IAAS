// VPC

# Outputs
output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_cidr" {
  value = aws_subnet.public.cidr_block
}

output "private_subnet_cidr" {
  value = aws_subnet.private.cidr_block
}

output "nat_gateway_id" {
  value = var.common_tags["EnableNAT"] == "true" ? aws_nat_gateway.nat[0].id : "NAT Disabled"
}




//  future resources

