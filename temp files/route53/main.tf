data "aws_route53_zone" "existing_zone" {
  name = "vicarius.xyz"
}

resource "aws_route53_record" "barkuni_record" {
  zone_id = data.aws_route53_zone.existing_zone.zone_id
  name    = "test.vicarius.xyz"
  type    = "A"

  alias {
    name                   = module.alb.lb_dns_name
    zone_id                = module.alb.lb_zone_id
    evaluate_target_health = true
  }
}