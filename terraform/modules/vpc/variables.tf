variable "env" {
  description = "Environment name such as dev, staging, or prod"
  type        = string
}

variable "vpc_cidr" {
  description = "Main CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "Availability Zones used by the VPC"
  type        = list(string)
}

variable "public_subnets" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "single_nat_gateway" {
  description = "Whether to use one NAT Gateway or one per AZ"
  type        = bool
}
