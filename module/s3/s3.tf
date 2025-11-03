resource "aws_s3_bucket" "main" {

  provider = aws.main
  bucket = local.bucket_name

  tags = local.resource_tags
}