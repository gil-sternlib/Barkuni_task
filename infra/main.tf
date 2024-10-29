provider "aws" {
  region = var.aws_region
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
  cluster_version = "1.27"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets
  tags            = var.tags
}

module "alb" {
  source = "./modules/alb"

  oidc_provider_arn = module.eks.oidc_provider_arn
}

//module "route53" {
////  source = "..\/temp files\/route53"
////
////  root_domain_name = "vi.xyz"
////  subdomain_name   = "test"
////  alb_dns_name     = module.alb.alb_dns_name
////  alb_zone_id      = module.alb.alb_zone_id
////  tags             = var.tags
////}