provider "aws" {
  region = var.aws_region
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    command     = "aws"
  }
}
}

module "vpc" {
  source = "./modules/vpc"

  vpc_name           = "barkuni-vpc"
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  tags               = var.tags
}

module "eks" {
  source = "./modules/eks"

  cluster_name    = "barkuni-cluster"
  cluster_version = "1.29"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets
  tags            = var.tags
}

module "alb" {
  source = "./modules/alb"

  oidc_provider_arn = data.aws_iam_openid_connect_provider.eks.arn
  cluster_oidc_issuer_url = module.eks.cluster_oidc_issuer_url
}

data "aws_iam_openid_connect_provider" "eks" {
 url = module.eks.cluster_oidc_issuer_url
}


module "helm" {
source = "./modules/helm"

cluster_endpoint     = module.eks.cluster_endpoint
cluster_name        = module.eks.cluster_name
lb_controller_role_arn = module.alb.lb_role_arn

}