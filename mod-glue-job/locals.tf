locals {
    resource_tags = merge(var.tags, {})

    job_tags = merge (
        {
            domain = "data"
        },
        local.resource_tags
    )
}

