data "aws_caller_identity" "current" {}

variable "region" {
    description = "The project region"
    type = string 
    default = "eu-central-1"
}

variable "account_id" {
    description = "The project account id"
    type = string
    default = "${data.aws_caller_identity.current.account_id}"
}