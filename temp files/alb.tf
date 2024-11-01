module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.2.0"

  name = "barkuni-alb"

  load_balancer_type = "application"
  internal           = false
  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.public_subnets

  security_groups = [aws_security_group.alb_sg.id]

  target_groups = [
    {
      name             = "barkuni-tg"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "ip"
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "production"
    Application = "barkuni"
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "barkuni-alb-sg"
  description = "Security group for the ALB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Terraform   = "true"
    Environment = "production"
    Application = "barkuni"
  }
}