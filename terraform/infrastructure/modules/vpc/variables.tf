variable "name" {
  description = "Vpc name"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block of VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the subnets públicas"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the subnets privadas"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Create NAT Gateway(s)"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Use only one shared NAT Gateway (cheaper)"
  type        = bool
  default     = false
}

variable "enable_flow_logs" {
  description = "Activates VPC Flow Logs"
  type        = bool
  default     = true
}
