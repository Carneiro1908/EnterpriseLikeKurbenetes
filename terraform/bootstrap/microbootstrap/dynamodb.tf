# Creating table
resource "aws_dynamodb_table" "main_bootstrap_table" {
    name = "main_bootstrap_table"
    billing_mode = "PAY_PER_REQUEST"

    attribute {
       name = "LockID"
       type = "S"
    }

    # Criptography
    server_side_encryption {
        enabled = true
        kms_key_arn = aws_kms_key.dynamodb_key.arn
    }

    # Point in time recovery
    point_in_time_recovery {
        enabled = true
    }
}