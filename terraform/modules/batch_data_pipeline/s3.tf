# resources
resource "aws_s3_bucket" "raw-data-bucket" {
    bucket  =   var.bucket_name

    tags = {
        Name    =   "raw-poker-bucket"
    }
}