resource "aws_dynamodb_table" "global_infra_dynamo_table" {
  name         = "global-infra-dynamo-table"
  billing_mode = "PAY_PER_REQUEST"  
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  server_side_encryption {
    enabled     = true
    kms_key_arn = aws_kms_key.global_infra_kms_key.arn
  }

  point_in_time_recovery {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}