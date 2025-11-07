resource "aws_s3_bucket" "main" {

  provider = aws.main
  bucket = local.bucket_name

  tags = local.resource_tags
}

resource "aws_s3_bucket_notification" "notificacion_s3" {
  provider = aws.main
  bucket   = aws_s3_bucket.main.id
  count    = (length(var.s3_notifications.lambda) > 0 ? 1 : 0)

  dynamic "lambda_function" {
    for_each = var.s3_notifications.enable_lambda ? var.s3_notifications.lambda : []
    content {
      lambda_function_arn = lambda_function.value.arn
      events              = lambda_function.value.events
    }
  }

}