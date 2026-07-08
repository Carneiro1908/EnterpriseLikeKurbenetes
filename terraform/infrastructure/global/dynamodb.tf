module "dev_env_table" {
    source = "../modules/dynamodb"

    table_name = "dev-environment-table"
    kms_key_arn = module.dev_env_bucket.kms_key_arn
}

module "staging_env_table" {
    source = "../modules/dynamodb" 

    table_name = "staging-environment-table"
    kms_key_arn = module.staging_env_bucket.kms_key_arn
}

module "prod_env_table" {
    source = "../modules/dynamodb"

    table_name = "prod-environment-table"
    kms_key_arn = module.prod_env_bucket.kms_key_arn
}