

# Define VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.tags, { Name = local.resources["vpc"] })

  lifecycle {
    prevent_destroy = true
  }
}

# Define Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, 0)
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = merge(local.tags, { Name = local.resources["public_subnet"] })
}

# Define Private Subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, 1)
  availability_zone = "us-east-1b"

  tags = merge(local.tags, { Name = local.resources["private_subnet"] })
}

# Create an Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.tags, { Name = local.resources["internet_gw"] })
}

# Create a Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = merge(local.tags, { Name = local.resources["public_rt"] })
}

# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Conditionally Create an Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = merge(local.tags, { Name = "${local.resources["nat_gateway"]}-EIP" })

  count = local.enable_nat ? 1 : 0
}

# Conditionally Create NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = local.enable_nat ? aws_eip.nat_eip[0].id : null
  subnet_id     = aws_subnet.public.id

  tags = merge(local.tags, { Name = local.resources["nat_gateway"] })

  depends_on = [aws_internet_gateway.gw]

  count = local.enable_nat ? 1 : 0
}

# Conditionally Create Private Route Table if NAT is enabled
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = local.enable_nat ? aws_nat_gateway.nat[0].id : null
  }

  tags = merge(local.tags, { Name = local.resources["private_rt"] })

  count = local.enable_nat ? 1 : 0
}

# Conditionally Associate Private Subnet with Private Route Table
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private[0].id

  count = local.enable_nat ? 1 : 0
}

