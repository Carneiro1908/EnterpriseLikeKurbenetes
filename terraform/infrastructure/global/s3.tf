# Creating buckets for state of environments

# NOTE: besides be non pratical, I will set force destroy on these buckets
# because is very helpfull on the debugging of the infrastructure, how ever
# if this was a really enterprise & comercial project, I would turn force destroy off

module "dev_env_bucket" {
    source = "../modules/s3"

    bucket_name = "dev-environment-bucket"

    force_destroy = true
}

module "staging_env_bucket" {
    source = "../modules/s3"

    bucket_name = "stating-environment-bucket"

    force_destroy = true
}

module "prod_env_bucket" {
    source = "../modules/s3"

    bucket_name = "prod-environment-bucket"

    force_destroy = true
}