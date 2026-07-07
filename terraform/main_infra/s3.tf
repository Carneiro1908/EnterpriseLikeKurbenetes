# DEV envinonment bucket
resource "aws_s3_bucket" "dev_env_bucket" { 
     bucket = "terraform-env-dev-bucket-${var.AWS_REGION}"

    lifecycle {
        prevent_destroy = true
    }   
}

# Adding security

# Blocking public access
resource "aws_s3_bucket_public_access_block" "dev_env_bucket_block" {
    bucket = aws_s3_bucket.dev_env_bucket.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}

# Auto criptografy
resource "aws_s3_bucket_server_side_encryption_configuration" "dev_env_bucket_encryption" {
    bucket = aws_s3_bucket.dev_env_bucket.id

    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}

# Versioning
resource "aws_s3_bucket_versioning" "dev_env_bucket_versioning" {
    bucket = aws_s3_bucket.dev_env_bucket.id

    versioning_configuration {
        status = "Enabled"
    }
}

# STAGING envinonment bucket
resource "aws_s3_bucket" "staging_env_bucket" { 
     bucket = "terraform-env-staging-bucket-${var.AWS_REGION}"

    lifecycle {
        prevent_destroy = true
    }   
}

# Adding security

# Blocking public access
resource "aws_s3_bucket_public_access_block" "staging_env_bucket_block" {
    bucket = aws_s3_bucket.staging_env_bucket.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}

# Auto criptografy
resource "aws_s3_bucket_server_side_encryption_configuration" "staging_env_bucket_encryption" {
    bucket = aws_s3_bucket.staging_env_bucket.id

    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}

# Versioning
resource "aws_s3_bucket_versioning" "staging_env_bucket_versioning" {
    bucket = aws_s3_bucket.staging_env_bucket.id

    versioning_configuration {
        status = "Enabled"
    }
}

# Prod envinonment bucket
resource "aws_s3_bucket" "prod_env_bucket" { 
     bucket = "terraform-env-prod-bucket-${var.AWS_REGION}"

    lifecycle {
        prevent_destroy = true
    }   
}

# Adding security

# Blocking public access
resource "aws_s3_bucket_public_access_block" "prod_env_bucket_block" {
    bucket = aws_s3_bucket.prod_env_bucket.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}

# Auto criptografy
resource "aws_s3_bucket_server_side_encryption_configuration" "prod_env_bucket_encryption" {
    bucket = aws_s3_bucket.prod_env_bucket.id

    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}

# Versioning
resource "aws_s3_bucket_versioning" "prod_env_bucket_versioning" {
    bucket = aws_s3_bucket.prod_env_bucket.id

    versioning_configuration {
        status = "Enabled"
    }
}