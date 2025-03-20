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

variable "aws_load_balancer_controller_version" {
  description = "helm chart aws lbc version"
  type = string
}

variable "ingress_nginx_version" {
  description = "helm chart ingress nginx version"
  type = string
}

variable "secrets_store_csi_driver_version" {
  description = "helm chart secrets csi driver version"
  type = string
}

variable "secrets_store_csi-driver_provider_aws_version" {
  description = "helm chart secrets csi driver aws version"
  type = string
}

variable "argocd_image_updater_version" {
  description = "helm chart image updater version"
  type = string
}


variable "argocd_version" {
  description = "helm chart image updater version"
  type = string
}




