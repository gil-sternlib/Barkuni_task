
output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "oidc_provider_arn" {
  # Use the ARN of the OIDC provider you created
  value = aws_iam_openid_connect_provider.eks.arn
}
