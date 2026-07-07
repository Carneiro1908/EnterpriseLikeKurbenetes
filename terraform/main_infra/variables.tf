data "aws_caller_identity" "current" {}

variable "AWS_REGION" {
    default = "eu-central-1"
    description = "The aws region from the project"
    type = string  
}

locals {
    account_id = data.aws_caller_identity.current.account_id
}
