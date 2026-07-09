locals {
  environment     = "dev"
  account_id = get_aws_account_id()
  cidr_block      = "10.0.0.0/16"
  backend_bucket  = "dev-environment-bucket-${local.account_id}"   
  backend_table   = "dev-environment-table"
}



