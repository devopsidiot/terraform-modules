terraform {
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "= 3.47.0"
    }
    newrelic = {
      source = "newrelic/newrelic"
      version = "~> 2.0"
    }
  }
}
