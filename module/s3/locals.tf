locals {
  required_tags = {
    env   = var.environment
    owner = var.owner
  }

  resource_tags = merge(
    var.tags,
    local.required_tags,
  )
}
