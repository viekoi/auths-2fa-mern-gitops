
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name                 = "${var.app_name}-${var.env}-vpc"
  cidr                 = var.vpc_cidr_block

  azs                  = var.azs
  private_subnets      = var.private_subnets
  public_subnets       = var.public_subnets
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.app_name}-${var.env}-vpc"
  }

 public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
    "kubernetes.io/cluster/${var.app_name}-${var.env}-eks" = "owned"
    "Name" = "${var.env}-public"
}

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
    "kubernetes.io/cluster/${var.app_name}-${var.env}-eks" = "owned"
    "Name" = "${var.env}-private"
  }
  
}
