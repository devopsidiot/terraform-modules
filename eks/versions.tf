terraform {
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.47.0, < 4.0.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14"
    }
    newrelic = {
      source = "newrelic/newrelic"
      version = "~> 2.0"
    }
  }
}
