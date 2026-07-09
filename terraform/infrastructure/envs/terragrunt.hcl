locals {
  account_id = get_aws_account_id()
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "eu-central-1"

  default_tags {
    tags = {
      ManagedBy = "terraform"
      Project   = "enterprise-like-k8s"
    }
  }
}
EOF
}