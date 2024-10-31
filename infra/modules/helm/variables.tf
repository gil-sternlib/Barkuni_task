variable "cluster_endpoint" {
  description = "EKS cluster endpoint"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "lb_controller_role_arn" {
  description = "ARN of the IAM role for the load balancer controller"
  type        = string
}