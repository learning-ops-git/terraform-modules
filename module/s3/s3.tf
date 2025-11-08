resource "aws_s3_bucket" "main" {

  provider = aws.main
  bucket = local.bucket_name

  tags = local.resource_tags
}

resource "aws_lambda_permission" "allow_s3_invocation" {
  provider = aws.main
  count    = (length(var.s3_notifications.lambda) > 0 ? length(var.s3_notifications.lambda) : 0)

  statement_id  = "AllowS3Invocation-${count.index}"
  action        = "lambda:InvokeFunction"
  function_name = var.s3_notifications.lambda[count.index].function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.main.arn
}

resource "aws_s3_bucket_notification" "notificacion_s3" {
  depends_on = [aws_lambda_permission.allow_s3_invocation]
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