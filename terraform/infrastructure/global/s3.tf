# Creating buckets for state of environments
module "dev_env_bucket" {
    source = "../modules/s3"

    bucket_name = "dev-environment-bucket"

    # temporaly
    force_destroy = true
}

module "staging_env_bucket" {
    source = "../modules/s3"

    bucket_name = "stating-environment-bucket"

    # temporaly
    force_destroy = true
}

module "prod_env_bucket" {
    source = "../modules/s3"

    bucket_name = "prod-environment-bucket"

    # temporaly
    force_destroy = true
}