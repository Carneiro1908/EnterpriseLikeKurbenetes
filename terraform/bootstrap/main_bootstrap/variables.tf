data "aws_caller_identity" "current" {}

variable "region" {
    description = "The AWS region to deploy resources in"
    type        = string    
    default     = "eu-central-1"
}

variable "account_id" {
    description = "The AWS account ID where resources will be deployed"
    type        = string
    default = "${data.aws_caller_identity.current.account_id}"
}