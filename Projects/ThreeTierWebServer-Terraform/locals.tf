
# Get environment-specific values
locals {
  tags      = var.common_tags[var.workspace_env]
  resources = var.resource_names[var.workspace_env]
  enable_nat = local.tags["EnableNAT"] == "true"
}