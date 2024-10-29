module "route53" {
  source = "./modules/route53"

  root_domain_name = "vicarius.xyz"
  subdomain_name   = "test"
  alb_dns_name     = module.alb.alb_dns_name
  alb_zone_id      = module.alb.alb_zone_id
  tags             = var.tags
}