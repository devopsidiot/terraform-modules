provider "flux" {}

provider "kubectl" {
  apply_retry_count      = 15
  host                   = var.cluster_endpoint
  cluster_ca_certificate = base64decode(var.cluster_certificate_authority_data)
  load_config_file       = false

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws-iam-authenticator"
    args = [
      "token",
      "-i",
      var.cluster_name,
      "-r",
      var.cluster_admin_role
    ]
  }
}

provider "kubernetes" {
  host                   = var.cluster_endpoint
  cluster_ca_certificate = base64decode(var.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["token", "-i", var.cluster_name, "-r", var.cluster_admin_role]
    command     = "aws-iam-authenticator"
  }

}

data "flux_install" "main" {
  target_path      = var.target_path
  version          = var.flux_version
  components       = ["source-controller", "kustomize-controller", "helm-controller", "notification-controller"]
  components_extra = ["image-reflector-controller", "image-automation-controller"]
}

data "kubectl_file_documents" "install" {
  content = data.flux_install.main.content
}
# Generate manifests
data "flux_sync" "main" {
  target_path = var.target_path
  url         = "https://github.com/${var.github_owner}/${var.repository_name}"
  branch      = var.flux_branch
}

# Split multi-doc YAML with
# https://registry.terraform.io/providers/gavinbunney/kubectl/latest
data "kubectl_file_documents" "sync" {
  content = data.flux_sync.main.content
}
resource "kubernetes_namespace" "flux_system" {
  metadata {
    name = "flux-system"
  }
}

# Generate a Kubernetes secret with the Git credentials
resource "kubernetes_secret" "main" {

  metadata {
    name      = data.flux_sync.main.secret
    namespace = data.flux_sync.main.namespace
  }

  data = {
    username = var.github_user
    password = var.flux_token
  }
}

# prepare install manifests to submit to kube
locals {
  install = [for v in data.kubectl_file_documents.install.documents : {
    data : yamldecode(v)
    content : v
    }
  ]
}

resource "kubectl_manifest" "install" {
  for_each   = { for v in local.install : lower(join("/", compact([v.data.apiVersion, v.data.kind, lookup(v.data.metadata, "namespace", ""), v.data.metadata.name]))) => v.content }
  depends_on = [kubernetes_namespace.flux_system]
  yaml_body  = each.value
}

# Convert documents list to include parsed yaml data\
#prepare GitRepository Sync document for initial repo setup
locals {
  sync = [for v in data.kubectl_file_documents.sync.documents : {
    data : yamldecode(v)
    content : v
    }
  ]
}

# Apply manifests on the cluster
resource "kubectl_manifest" "sync" {
  for_each   = { for v in local.sync : lower(join("/", compact([v.data.apiVersion, v.data.kind, lookup(v.data.metadata, "namespace", ""), v.data.metadata.name]))) => v.content }
  depends_on = [kubernetes_namespace.flux_system]
  yaml_body  = each.value
}

