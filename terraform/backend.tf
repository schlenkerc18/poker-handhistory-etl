# configure backend for terraform using aws
terraform {
    backend "s3" {
        bucket  =   "terraform-state-config-21"
        key     =   "terraform-state"
        region  =   "us-east-2"
#         dynamodb    =   ""  use this if working with users to avoid concurrent updates
        encrypt =   true
    }
}