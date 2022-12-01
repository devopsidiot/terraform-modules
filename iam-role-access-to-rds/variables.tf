variable "rds_cluster_access" {
  type = object(
    {
      rds_cluster_name    = string,
      rds_cluster_account = string,
      rds_cluster_region  = string,
      rds_user_name       = string
    }
  )
  description = "RDS Cluster attributes to give IAM role access to"
}
