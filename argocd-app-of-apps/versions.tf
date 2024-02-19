terraform {
  required_providers {
    argocd = {
      source  = "oboukili/argocd"
      version = "5.6.0"
    }
    newrelic = {
      source  = "newrelic/newrelic"
      version = "~> 2.0"
    }
  }
}
