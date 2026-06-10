module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.env}-enterprise-eks"
  cluster_version = var.cluster_version

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  cluster_endpoint_public_access = true

  enable_irsa = true

  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  eks_managed_node_groups = {
    default = {
      name = "${var.env}-node-group"

      instance_types = var.instance_types

      min_size     = var.min_size
      desired_size = var.desired_size
      max_size     = var.max_size

      capacity_type = "ON_DEMAND"
    }
  }

  tags = {
    Project     = "enterprise-project"
    Environment = var.env
    ManagedBy   = "Terraform"
  }
}


