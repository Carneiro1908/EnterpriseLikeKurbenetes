terraform {
    required_version = ">= 1.0.0"

    backend "s3" {
        bucket         = "terraform-main-infra-bucket-eu-central-1"
        key            = "environment/main_infra/terraform.tfstate"
        region         = ""
        dynamodb_table = "main_bootstrap_table" 
        encrypt        = true
    }
}