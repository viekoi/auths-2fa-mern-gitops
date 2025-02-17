variable "env" {
  description = "Environment name."
  type        = string
}

variable "app_name" {
  description = "App name."
  type        = string
  default     = "auths-2fa-mern"
}

variable "vpc_cidr_block" {
  description = "CIDR (Classless Inter-Domain Routing)."
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Availability zones for subnets."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "private_subnets" {
  description = "CIDR ranges for private subnets."
  type        = list(string)
  default     = ["10.0.0.0/19", "10.0.32.0/19"]
}

variable "public_subnets" {
  description = "CIDR ranges for public subnets."
  type        = list(string)
  default     = ["10.0.64.0/19", "10.0.96.0/19"]
}

variable "kubernetes_version" {
  default     = 1.32
  description = "kubernetes version"
}