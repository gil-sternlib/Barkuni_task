module "eks" {
source = "terraform-aws-modules/eks/aws"
version = "19.0.0"

cluster_name    = var.cluster_name
cluster_version = var.cluster_version

vpc_id     = var.vpc_id
subnet_ids = var.subnet_ids

cluster_endpoint_public_access  = true
cluster_endpoint_private_access = true
cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]

eks_managed_node_groups = {
main = {
desired_size = var.node_desired_size
min_size     = var.node_min_size
max_size     = var.node_max_size

instance_types = var.instance_types
capacity_type  = "ON_DEMAND"
}
}

tags = var.tags
}


