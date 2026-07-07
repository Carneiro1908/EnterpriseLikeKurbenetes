terraform {
    required_version = ">= 1.0.0"

    backend "s3" {
        bucket         = "terraform-main-bootstrap-bucket-eu-central-1"
        key            = "enviroment/bootstrap/terraform.tfstate"
        region         = ""
        dynamodb_table = "main_bootstrap_table" 
        encrypt        = true
    }
}