locals {
  required_tags = {
    env   = var.environment
    owner = var.owner
  }

  resource_tags = merge(
    var.tags,
    local.required_tags,
  )

  bucket_name = "${var.country}-${var.domain}-${var.account_id}-${var.environment}-${var.suffix}"
}
