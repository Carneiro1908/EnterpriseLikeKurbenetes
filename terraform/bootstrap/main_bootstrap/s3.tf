# Creating bucket
resource "aws_s3_bucket" "main_infra_bucket" {
    bucket = "terraform-main-infra-bucket-${var.region}"

    lifecycle {
        prevent_destroy = true
    }
}

# Adding security

# Blocking public access
resource "aws_s3_bucket_public_access_block" "main_infra_bucket_block" {
    bucket = aws_s3_bucket.main_infra_bucket.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}

# Auto criptografy
resource "aws_s3_bucket_server_side_encryption_configuration" "main_infra_bucket_encryption" {
    bucket = aws_s3_bucket.main_infra_bucket.id

    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}

# Versioning
resource "aws_s3_bucket_versioning" "main_infra_bucket_versioning" {
    bucket = aws_s3_bucket.main_infra_bucket.id

    versioning_configuration {
        status = "Enabled"
    }
}