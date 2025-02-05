# Define VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"

  tags = merge(var.common_tags, {
    Name = var.resource_names["vpc"]
  })

  lifecycle {
    prevent_destroy = true  # Prevent accidental deletion
  }
}

# Define Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, 0)
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = merge(var.common_tags, {
    Name = var.resource_names["public_subnet"]
  })
}

# Define Private Subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, 1)
  availability_zone = "us-east-1b"

  tags = merge(var.common_tags, {
    Name = var.resource_names["private_subnet"]
  })
}

# Create an Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.common_tags, {
    Name = var.resource_names["internet_gw"]
  })
}

# Create a Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = merge(var.common_tags, {
    Name = var.resource_names["public_rt"]
  })
}

# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Conditionally Create an Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = merge(var.common_tags, {
    Name = "${var.resource_names["nat_gateway"]}-EIP"
  })

  count = var.common_tags["EnableNAT"] == "true" ? 1 : 0
}

# Conditionally Create NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = var.common_tags["EnableNAT"] == "true" ? aws_eip.nat_eip[0].id : null
  subnet_id     = aws_subnet.public.id

  tags = merge(var.common_tags, {
    Name = var.resource_names["nat_gateway"]
  })

  depends_on = [aws_internet_gateway.gw]

  count = var.common_tags["EnableNAT"] == "true" ? 1 : 0
}

# Conditionally Create Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.common_tags["EnableNAT"] == "true" ? aws_nat_gateway.nat[0].id : null
  }

  tags = merge(var.common_tags, {
    Name = var.resource_names["private_rt"]
  })

  count = var.common_tags["EnableNAT"] == "true" ? 1 : 0
}

# Conditionally Associate Private Subnet with Private Route Table
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private[0].id

  count = var.common_tags["EnableNAT"] == "true" ? 1 : 0
}

