locals {
  environment     = "staging"
  account_id = get_aws_account_id()
  cidr_block      = "10.0.0.0/16"
  backend_bucket  = "staging-environment-bucket-${account_id}"   
  backend_table   = "staging-environment-table"
}
