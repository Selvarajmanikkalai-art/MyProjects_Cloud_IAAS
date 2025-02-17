output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = data.aws_subnets.subnets.ids
}

