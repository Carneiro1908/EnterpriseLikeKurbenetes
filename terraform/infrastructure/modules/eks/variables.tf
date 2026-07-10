variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type    = string
  default = "1.30"
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "public_subnet_ids" {
  type    = list(string)
  default = []
}

variable "endpoint_public_access" {
  type    = bool
  default = false
}

variable "endpoint_public_access_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "enable_irsa" {
  type    = bool
  default = true
}

variable "enable_cluster_encryption" {
  type    = bool
  default = true
}

variable "cluster_log_types" {
  type    = list(string)
  default = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "node_groups" {
  description = "Managed node groups, in the oficial format of terraform-aws-modules/eks"
  type = map(object({
    instance_types = list(string)
    capacity_type  = string
    min_size       = number
    max_size       = number
    desired_size   = number
    disk_size      = optional(number, 20)
  }))
}

variable "enable_monitoring" {
  type    = bool
  default = false
}


variable "enable_observability" {
  type        = bool
  default     = false
}

variable "grafana_admin_password" {
  type      = string
  sensitive = true
  default   = "1234567890@grafana.password"
}

variable "tags" {
  type    = map(string)
  default = {}
}