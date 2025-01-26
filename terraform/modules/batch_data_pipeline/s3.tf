# resources
resource "aws_s3_bucket" "raw_data_bucket" {
    bucket  =   var.bucket_name

    tags = {
        Name    =   "raw-poker-bucket"
    }
}

resource "aws_s3_bucket" "transformed_data_bucket" {
    bucket  =   var.transformed_bucket_name
}

resource "aws_s3_bucket" "etl_scripts" {
    bucket  =   var.etl_script_bucket_name

    tags    = {
        Name    =   "hand-history-etl-script"
    }
}

# # Upload local file to S3 bucket
resource "aws_s3_object" "example_file" {
  bucket = aws_s3_bucket.etl_scripts.bucket
  key    = "/${var.etl_script_name}"  # Replace with the desired S3 key (path in the bucket)
  source = "../src/${var.etl_script_name}"  # Replace with the path to your local file
  acl    = "private"
}