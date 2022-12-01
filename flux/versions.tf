terraform {
  required_providers {

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.2"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.10.0"
    }
    flux = {
      source  = "fluxcd/flux"
      version = ">= 0.0.13, < 0.14.1"
    }
    newrelic = {
      source = "newrelic/newrelic"
      version = "~> 2.0"
    }
  }
}
