data "aws_iam_policy_document" "iam_assume_role_access_for_k8s_service_account" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [var.eks_cluster_attributes["oidc_provider_arn"]]
    }

    condition {
      test     = "StringEquals"
      variable = "${trimprefix(var.eks_cluster_attributes["cluster_oidc_issuer_url"], "https://")}:sub"

      values = [
        "system:serviceaccount:${var.namespace}:${var.service_name}"
      ]
    }
  }
}
