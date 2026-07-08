resource "aws_kms_key" "ecr_key" {
  description             = "KMS key to encrypt KMS iamges"
  deletion_window_in_days = 30
  enable_key_rotation     = true
}

resource "aws_kms_alias" "ecr_key" {
  name          = "alias/ecr-app"
  target_key_id = aws_kms_key.ecr_key.key_id
}