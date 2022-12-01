data "aws_rds_cluster" "rds_cluster_to_access" {
  cluster_identifier = var.rds_cluster_access["rds_cluster_name"]
}

data "aws_iam_policy_document" "iam_role_access_to_rds" {
  statement {
    actions = [
      "rds-db:connect"
    ]

    resources = [
      "arn:aws:rds-db:${var.rds_cluster_access["rds_cluster_region"]}:${var.rds_cluster_access["rds_cluster_account"]}:dbuser:${data.aws_rds_cluster.rds_cluster_to_access.cluster_resource_id}/${var.rds_cluster_access["rds_user_name"]}"
    ]
  }
}
