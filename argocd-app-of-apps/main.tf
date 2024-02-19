provider "argocd" {
  server_addr = "argo.${var.argo_environment}.devopsidiot.com"
  username    = var.argo_initial_username
  password    = var.argo_initial_password
}

# Argo repo setup
resource "argocd_repository" "glorify_github" {
  repo            = "git@github.com:devopsidiot/gitops2024.git"
  username        = var.githubapp_id
  ssh_private_key = var.github_ssh
  insecure        = true
}

# App of apps declaration
resource "argocd_application" "world-eater" {
  metadata {
    name      = "world-eater"
    namespace = "argo"
  }
  spec {
    project = "default"
    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "argo"
    }
    source {
      repo_url        = argocd_repository.devopsidiot_github.repo
      target_revision = var.argo_environment
      path            = var.workloads_directory
      directory {
        recurse = true
      }
    }
    sync_policy {
      automated {
        prune     = false
        self_heal = true
      }
    }
  }
}

# Local helm chart-museum to reference charts
resource "argocd_repository" "chart_museum" {
  repo = "http://chartmuseum.chartmuseum.svc:8080"
  name = "service"
  type = "helm"
}

resource "argocd_repository" "word_eater" {
  repo            = "git@github.com:devopsidiot/service.git"
  username        = var.githubapp_id
  ssh_private_key = var.github_ssh
  insecure        = true
}
