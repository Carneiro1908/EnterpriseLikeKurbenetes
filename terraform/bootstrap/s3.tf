resource "aws_s3_bucket" "global_infra_bucket" {
    bucket = "global-infrastructure-bucket"

    lifecycle {
      prevent_destroy = true
    }
}

# Bucket versioning
resource "aws_s3_bucket_versioning" "global_infra_bucket_versioning" {
    bucket = aws_s3_bucket.global_infra_bucket.id

    versioning_configuration {
      status = "Enabled"
    }
}

# Encrypitaion
resource "aws_s3_bucket_server_side_encryption_configuration" "global_infra_bucket_encrypitation" {
  bucket = aws_s3_bucket.global_infra_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
      kms_master_key_id = aws_kms_key.global_infra_kms_key.arn
    }
    bucket_key_enabled = true
  }
}

# Block public acsses
resource "aws_s3_bucket_public_access_block" "global_infra_bucket_block" {
  bucket = aws_s3_bucket.global_infra_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Life cycle config
resource "aws_s3_bucket_lifecycle_configuration" "global_infra_bucket_lifecycle_config" {
  bucket = aws_s3_bucket.global_infra_bucket.id

  rule {
    id     = "expire-old-versions"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 90
    }
  }
}