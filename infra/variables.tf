variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "private_subnets" {
description = "Private subnet CIDRs"
type        = list(string)
default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
description = "Public subnet CIDRs"
type        = list(string)
default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "tags" {
description = "Tags for resources"
type        = map(string)
default     = {
Environment = "dev"
Project     = "barkuni"
Terraform   = "true"
}
}