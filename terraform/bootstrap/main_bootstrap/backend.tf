terraform {
    required_version = ">= 1.0.0"

    backend "s3" {
        bucket         = ""
        key            = ""
        region         = ""
        dynamodb_table = "main_bootstrap_table" 
        encrypt        = true
    }
}