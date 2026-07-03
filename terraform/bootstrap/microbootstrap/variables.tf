data "aws_caller_identity" "current" {}

variable "region" {
    description = "The project region"
    type = string 
    default = "eu-central-1"
}

locals {
    account_id = data.aws_caller_identity.current.account_id
}