# input
variable "bucket_name" {
    description =   "s3 bucket name for raw data storage"
    type        =   string
    default     =   "schle1-personal-raw-data-bucket"
}

variable "region" {
    description =   "region for aws resources"
    type        =   string
    default     =   "us-east-2"
}

variable "lambda_function_name" {
    description =   "name for lambda function that triggers glue jobs"
    type        =   string
    default     =   "triggerGlueJob"
}