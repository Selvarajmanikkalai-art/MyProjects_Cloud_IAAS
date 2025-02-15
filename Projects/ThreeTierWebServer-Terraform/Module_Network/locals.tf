
# # Get environment-specific values
# locals {
#   workspace_env = lower(var.workspace_env)
#   tags       = var.common_tags[var.workspace_env]
#   resources  = var.resource_names[var.workspace_env]
#   EnableNAT = var.EnableNAT[local.workspace_env]
# }

  
locals {
  workspace_env = lower(var.workspace_env)  # Normalize workspace name
  tags       = var.common_tags[var.workspace_env]
  resources  = var.resource_names[var.workspace_env]
  enable_nat    = lookup(var.EnableNAT, local.workspace_env, false)  # Extract the boolean value safely
  
}

# count = local.enable_nat ? 1 : 0
