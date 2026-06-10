variable "env" {
  description = "Environment name such as dev, staging, or prod"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where EKS will be deployed"
  type        = string
}

variable "private_subnets" {
  description = "Private subnet IDs for EKS worker nodes"
  type        = list(string)
}

variable "instance_types" {
  description = "EC2 instance types for EKS managed nodes"
  type        = list(string)
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
}
