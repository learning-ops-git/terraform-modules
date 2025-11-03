resource "aws_s3_bucket" "main" {
    
  provider = aws.main
  bucket = var.bucket_name

  tags = local.resource_tags
}