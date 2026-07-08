variable "bucket_name" {
  description = "Bucket S3 name"
  type        = string
}

variable "versioning_enabled" {
  description = "Enable bucket versioning"
  type        = bool
  default     = true
}

variable "kms_key_arn" {
  description = "KMS key deticated arn"
  type        = string
  default     = null
}

variable "create_kms_key" {
  description = "Choice to create or not kms key"
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "It enables to destroy bucket even with objects inside"
  type        = bool
  default     = false
}

variable "enable_lifecycle" {
  description = "Activates lifecylce to clear old versions"
  type        = bool
  default     = true
}

variable "noncurrent_version_expiration_days" {
  type        = number
  default     = 90
}

variable "tags" {
  type        = map(string)
  default     = {}
}