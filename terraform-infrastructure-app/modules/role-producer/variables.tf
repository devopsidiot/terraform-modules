variable "service_name" {
  type        = string
  description = "The name of the application"
}

variable "namespace" {
  type        = string
  description = "The kubernetes namespace this application will reside in"
}

variable "ssm_scopes" {
  type        = set(string)
  description = "What ssm parameter paths should this application have access to?"
}


variable "eks_cluster_attributes" {
  type = object(
    {
      cluster_oidc_issuer_url = string,
      oidc_provider_arn       = string,
    }
  )
  description = "EKS Cluster attributes to be pulled from EKS module attributes"
}

variable "shared_rds_access" {
  type = object(
    {
      rds_cluster_name    = string,
      rds_cluster_account = string,
      rds_cluster_region  = string,
      rds_user_name       = string
    }
  )
  description = "Shared RDS Cluster attributes to give IAM role access to"
}

variable "shared_sns_access" {
  type = object(
    {
      topic       = string,
      permissions = set(string)
    }
  )
  description = "Which SNS topic does this application need access to, and with what permissions?"
}

variable "created_qldb_access" {
  type = string
  description = "Which QLDB Ledger does this application create and need access to?"
}
variable "shared_qldb_access" {
  type = string
  description = "Which QLDB Ledger does this application need access to?"
}

variable "created_sns_access" {
  type = list(string)
  description = "Which SNS topic does this application create and need access to?"
}

variable "created_sqs_access" {
  type = object(
    {
      queue       = string,
      permissions = set(string)
    }
  )
  description = "Which SQS queue does this application create and need access to, and with what permissions?"
}

variable "shared_s3_access" {
  type = object(
    {
      bucket       = string,
      permissions = set(string)
    }
  )
  description = "What S3 bucket does this applcation need access to, and with what permissions?"
}

variable "created_s3_access" {
  type = object(
    {
      bucket       = string,
      permissions = set(string)
    }
  )
  description = "What S3 bucket does this applcation create and need access to, and with what permissions?"
}