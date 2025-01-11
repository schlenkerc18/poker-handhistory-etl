resource "aws_lambda_function" "raw_data_upload_trigger" {
  function_name = var.lambda_function_name
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.10"
  role          = aws_iam_role.lambda_execution_role.arn
  memory_size   = 128
  timeout       = 3
  architectures = ["x86_64"]
  filename      = "../src/lambda_function.zip"

  environment {
    variables = {
      BUCKET_NAME = var.bucket_name
    }
  }

  ephemeral_storage {
    size = 512
  }

}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = var.bucket_name

  lambda_function {
    lambda_function_arn = aws_lambda_function.raw_data_upload_trigger.arn
    events              = ["s3:ObjectCreated:*"]
  }
}


resource "aws_lambda_permission" "allow_s3_to_invoke" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.raw_data_upload_trigger.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.raw-data-bucket.arn
}