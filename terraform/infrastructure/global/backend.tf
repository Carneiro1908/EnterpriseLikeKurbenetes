terraform {
    backend "s3" {
      key = "environment/global/terraform.tfstate"
      region = "eu-central-1"
      encrypt = true
      dynamodb_table = "global-infra-dynamodb-table"
    }
}