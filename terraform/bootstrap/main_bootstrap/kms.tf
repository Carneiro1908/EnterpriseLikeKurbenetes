resource "aws_kms_key" "dynamodb_key" {
  description             = "KMS key for DynamoDB encryption"
  deletion_window_in_days = 30
  enable_key_rotation     = true # Boa prática de segurança
}