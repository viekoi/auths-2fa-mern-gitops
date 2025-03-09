variable "env" {
  description = "Environment name."
  type        = string
}

variable "region" {
  description = "Region name."
  type        = string
}

variable "app_name" {
  description = "App name."
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR (Classless Inter-Domain Routing)."
  type        = string
}

variable "azs" {
  description = "Availability zones for subnets."
  type        = list(string)
}

variable "private_subnets" {
  description = "CIDR ranges for private subnets."
  type        = list(string)
}

variable "public_subnets" {
  description = "CIDR ranges for public subnets."
  type        = list(string)
}

variable "kubernetes_version" {
  description = "kubernetes version"
  type = number
}

variable "cert_manager_version" {
  description = "helm chart cert manager version"
  type = string
}

variable "cluster_autoscaler_version" {
  description = "helm chart cluster autoscaler version"
  type = string
}

variable "aws_lbc_version" {
  description = "helm chart aws lbc version"
  type = string
}

variable "ingress_nginx_version" {
  description = "helm chart ingress nginx version"
  type = string
}


