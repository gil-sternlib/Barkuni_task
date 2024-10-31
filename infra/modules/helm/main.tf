data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
token                  = data.aws_eks_cluster_auth.cluster.token
}
}

resource "helm_release" "aws_load_balancer_controller" {
name       = "aws-load-balancer-controller"
repository = "https://aws.github.io/eks-charts"
chart      = "aws-load-balancer-controller"
namespace  = "kube-system"

set {
name  = "clusterName"
value = var.cluster_name
}

set {
name  = "serviceAccount.create"
value = "false"
}

//set {
//name  = "serviceAccount.name"
//value = "aws-load-balancer-controller"
//}

set {
name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
value = var.lb_controller_role_arn
}
}