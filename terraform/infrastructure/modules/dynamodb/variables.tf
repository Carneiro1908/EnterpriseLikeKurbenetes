variable "table_name" {
  type        = string
}

variable "hash_key" {
  description = "Hash key name (partition key)"
  type        = string
  default     = "LockID"
}

variable "hash_key_type" {
  description = "Hash key type (S, N, B)"
  type        = string
  default     = "S"
}

variable "billing_mode" {
  description = "Billing mode: PAY_PER_REQUEST or PROVISIONED"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "kms_key_arn" {
  type        = string
  default     = null
}

variable "point_in_time_recovery_enabled" {
  description = "Enable point-in-time recovery"
  type        = bool
  default     = true
}

variable "prevent_destroy" {
  type        = bool
  default     = true
}

variable "tags" {
  type        = map(string)
  default     = {}
}