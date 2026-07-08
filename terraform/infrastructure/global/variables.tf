data "aws_caller_identity" "current" {}

locals {
  aws_account_id = data.aws_caller_identity.current.account_id
}

variable "REGION" {
    type = string
    default = "eu-central-1"
    description = "Project region"
}
