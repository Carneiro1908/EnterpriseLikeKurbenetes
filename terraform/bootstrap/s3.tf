module "state_bucket" {
  source = "../infrastructure/modules/s3"

  bucket_name = "global-infrastructure-bucket"

  enable_lifecycle = true 
  versioning_enabled = true  
  force_destroy = false  
  create_kms_key = true

  tags = {
    Name      = "terraform-state"
    ManagedBy = "terraform"
  }
}