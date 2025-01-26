# input
variable "bucket_name" {
    description =   "s3 bucket name for raw data storage"
    type        =   string
    default     =   "schle1-personal-raw-data-bucket"
}

variable "etl_script_bucket_name" {
    description =   "s3 bucket name for storing etl scripts"
    type        =   string
    default     =   "hand-history-etl"
}

variable "transformed_bucket_name" {
    description =   "s3 bucket for storing transformed files"
    type        =   string
    default     =   "schle1-personal-transformed-data-bucket"
}

variable "etl_script_name" {
    description =   "script for etl process"
    type        =   string
    default     =   "transform_hand_history.py"
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