module "vpc" {
  source = "../../modules/vpc"

  env = "staging"

  vpc_cidr = "10.20.0.0/16"

  azs = [
    "us-east-1a",
    "us-east-1b"
  ]

  public_subnets = [
    "10.20.1.0/24",
    "10.20.2.0/24"
  ]

  private_subnets = [
    "10.20.10.0/24",
    "10.20.11.0/24"
  ]

  single_nat_gateway = true
}

module "ecr" {
  source = "../../modules/ecr"

  env = "staging"
}

module "eks" {
  source = "../../modules/eks"

  env             = "staging"
  cluster_version = "1.31"

  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets

  instance_types = ["t3.medium"]

  min_size     = 1
  desired_size = 2
  max_size     = 3
}

