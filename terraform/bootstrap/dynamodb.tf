module "state_lock_table" {
  source = "../infrastructure/modules/dynamodb"

  table_name  = "global-infra-dynamodb-table"
  kms_key_arn = module.state_bucket.kms_key_arn  # reutiliza a mesma KMS key

  tags = {
    Name      = "terraform-locks"
    ManagedBy = "terraform"
  }
}