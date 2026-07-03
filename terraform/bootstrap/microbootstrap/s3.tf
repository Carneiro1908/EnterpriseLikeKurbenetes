# Creating bucket
resource "aws_s3_bucket" "main_bootstrap_bucket" {
    bucket = "terraform-main-bootstrap-bucket-${var.account_id}-${var.region}"

    lifecycle {
        prevent_destroy = true
    }
}

# Adding security

# Blocking public acsses
resource "aws_s3_bucket_public_acsses_block" "main_bootstrap_bucket_block" {
    bucket = aws_s3_bucket.main_bootstrap_bucket.id

    block_public_acsses       = true
    block_public_policy       = true
    ignore_public_acsses      = true
    restrict_public_buckets   = true
}

# Auto criptografy
resource "aws_s3_bucket_server_side_encryption_configuration" "main_bootstrap_bucket_encryption" {
    bucket = aws_s3_bucket.main_bootstrap_bucket.id

    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}

# Versioning
resource "aws_s3_bucket_versioning" "main_bootstrap_bucket_versioning" {
    bucket = aws_s3_bucket.main_bootstrap_bucket.id

    versioning_configuration {
        status = "Enabled"
    }
}