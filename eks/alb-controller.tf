resource "helm_release" "alb_controller" {
  name             = "alb"
  namespace        = "alb"
  create_namespace = "true"
  repository       = "https://aws.github.io/eks-charts"
  chart            = "aws-load-balancer-controller"
  version          = "1.5.3"

  set {
    name  = "clusterName"
    value = var.cluster_name
  }
}
