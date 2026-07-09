locals {
  environment     = "prod"
  account_id = get_aws_account_id()
  cidr_block      = "10.0.0.0/16"
  backend_bucket  = "prod-environment-bucket-${account_id}"   
  backend_table   = "prod-environment-table"
}
