include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket         = local.env_vars.locals.backend_bucket
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = local.env_vars.locals.backend_table
  }
}

terraform {
  source = "../../../modules/vpc"
}

inputs = {
  name       = "enterprise-like-k8s-${local.env_vars.locals.environment}"
  cidr_block = local.env_vars.locals.cidr_block
  azs        = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]

  public_subnet_cidrs  = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]

  single_nat_gateway = local.env_vars.locals.environment != "prod"

  tags = {
    Environment = local.env_vars.locals.environment
  }
}