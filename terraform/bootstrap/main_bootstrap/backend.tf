terraform {
    required_version = ">= 1.0.0"

    #bucket         = "terraform-main-infra-bucket-${var.account_id}-${var.region}"
    #    key            = "terraform.tfstate"
    #    region         = var.region
    #    dynamodb_table = "main_bootstrap_table"
    #    encrypt       = true

    backend "s3" {
        
    }
}