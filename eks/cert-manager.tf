resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  namespace        = "cert-manager"
  create_namespace = "true"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "v1.11.5"

  set {
    name  = "installCRDs"
    value = "true"
  }
}
