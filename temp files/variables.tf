variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "barkuni-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "eks_cluster_name" {
description = "Name of the EKS cluster"
type        = string
default     = "barkuni-eks-cluster"
}

variable "eks_cluster_version" {
description = "Version of the EKS cluster"
type        = string
default     = "1.30"
}

variable "eks_node_group_name" {
description = "Name of the EKS node group"
type        = string
default     = "barkuni-node-group"
}