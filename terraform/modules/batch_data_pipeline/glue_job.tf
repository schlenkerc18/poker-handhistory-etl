resource "aws_iam_role" "glue_role" {
  name = "glue_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "glue.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "glue_policy" {
  name = "glue_policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ],
        Effect = "Allow",
        Resource = "*"
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "glue_policy_attachment" {
  role       = aws_iam_role.glue_role.name
  policy_arn = aws_iam_policy.glue_policy.arn
}

resource "aws_glue_job" "transform-hand-history-job" {
  name        = "transform-hand-history"
  role_arn    = aws_iam_role.glue_role.arn
  command {
    name            = "glueetl"
    script_location = "s3://${var.etl_script_bucket_name}/${var.etl_script_name}"  # Adjust the S3 bucket and script path
    python_version  = "3"  # Adjust Python version if needed
  }
  default_arguments = {
    "--SOURCE_BUCKET" = "s3://${var.bucket_name}"  # Adjust the S3 bucket and path
    "--TARGET_BUCKET" = "s3://${var.transformed_bucket_name}"
  }
  max_retries = 1
  glue_version = "2.0"  # Adjust Glue version if needed
}
