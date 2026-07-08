resource "aws_kms_key" "global_infra_kms_key" {
  deletion_window_in_days = 30
  enable_key_rotation     = true
}

resource "aws_kms_alias" "global_infra_kms_key" {
  name          = "alias/global_infra_kms_key"
  target_key_id = aws_kms_key.global_infra_kms_key.key_id
}