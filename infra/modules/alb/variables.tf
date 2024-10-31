variable "oidc_provider_arn" {
  description = "ARN of the OIDC Provider"
  type        = string
}

variable "cluster_oidc_issuer_url" {
  description = "The OIDC issuer URL for the EKS cluster"
  type        = string
}