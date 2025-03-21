module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.app_name}-eks"
  cluster_version = var.kubernetes_version
  

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }


  vpc_id = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets

  cluster_endpoint_public_access = true
  cluster_endpoint_private_access = false
  enable_irsa         = true
  authentication_mode = "API_AND_CONFIG_MAP"
  enable_cluster_creator_admin_permissions = true

  tags = {
    Name = "${var.app_name}-eks"
  }

  eks_managed_node_group_defaults = {
    ami_type       = "AL2023_x86_64_STANDARD"
    instance_types         = ["t2.medium"]
  }

  eks_managed_node_groups = {
    node_group = {
      min_size     = 1
      max_size     = 3
      desired_size = 1
    }
  }
}