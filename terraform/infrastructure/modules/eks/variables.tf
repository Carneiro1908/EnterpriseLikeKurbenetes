variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.30"
}

variable "vpc_id" {
  description = "VPC ID where the cluster will run"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnets for the nodes (recommended, more secure)"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "Public subnets — only needed if the control plane requires a public endpoint"
  type        = list(string)
  default     = []
}

variable "endpoint_public_access" {
  description = "Allow access to the API server via the public internet"
  type        = bool
  default     = false
}

variable "endpoint_public_access_cidrs" {
  description = "CIDRs allowed to access the public endpoint (only relevant if endpoint_public_access = true)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "node_groups" {
  description = "Configuration for the managed node groups"
  type = map(object({
    instance_types = list(string)
    capacity_type  = string # ON_DEMAND or SPOT
    min_size       = number
    max_size       = number
    desired_size   = number
    disk_size      = number
  }))
  default = {
    default = {
      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
      min_size       = 1
      max_size       = 3
      desired_size   = 2
      disk_size      = 50
    }
  }
}

variable "enable_irsa" {
  description = "Enable IAM Roles for Service Accounts (required for pods to assume IAM roles)"
  type        = bool
  default     = true
}

variable "enable_cluster_encryption" {
  description = "Encrypt Kubernetes secrets with KMS"
  type        = bool
  default     = true
}

variable "cluster_log_types" {
  description = "Control plane log types to send to CloudWatch"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}