# NOTE: besides be non pratical, I will set force destroy on these buckets
# because is very helpfull on the debugging of the infrastructure, how ever
# if this was a really enterprise & comercial project, I would turn force destroy off

module "state_bucket" {
  source = "../infrastructure/modules/s3"

  bucket_name = "global-infrastructure-bucket"

  enable_lifecycle = true 
  versioning_enabled = true  
  force_destroy = true
  create_kms_key = true

  tags = {
    Name      = "terraform-state"
    ManagedBy = "terraform"
  }
}