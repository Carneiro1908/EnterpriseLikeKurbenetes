data "aws_caller_identity" "current" {}

variable "region" {
    description = "The AWS region to deploy resources in"
    type        = string    
    default     = "eu-central-1"
}

locals {
    account_id = data.aws_caller_identity.current.account_id
}