module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.5.1"

  cluster_name    = var.eks_cluster_name
  cluster_version = var.eks_cluster_version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    first = {
      name_prefix = var.eks_node_group_name
      instance_types = ["t3.small"]
      min_size     = 1
      max_size     = 5
      desired_size = 2
    }
  }

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  create_iam_role = true
  iam_role_name   = "barkuni-eks-cluster-role"

  cluster_security_group_id = aws_security_group.eks_cluster_sg.id

  tags = {
    Terraform   = "true"
    Environment = "production"
    Application = "barkuni"
  }
}

resource "aws_security_group" "eks_cluster_sg" {
  name        = "barkuni-eks-cluster-sg"
  description = "Security group for the EKS cluster"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Terraform   = "true"
    Environment = "production"
    Application = "barkuni"
  }
}