# I hate that I have to do this
terraform {
  experiments = [module_variable_optional_attrs]
  required_providers {
    newrelic = { source = "newrelic/newrelic" }
  }
}

data "aws_iam_policy_document" "argo_image_updater_ecr" {
  statement {
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:GetAuthorizationToken"
    ]
    resources = ["*"]
  }
}
resource "aws_iam_policy" "argo_image_updater_ecr" {
  name        = "${var.environment}-argo-image-updater-ecr-policy"
  description = "${var.environment}-argo-image-updater-ecr-policy"
  policy      = data.aws_iam_policy_document.argo_image_updater_ecr.json
}

module "iam_assumable_role_argo_image_updater_ecr" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version                       = "4.7.0"
  create_role                   = true
  role_name                     = "${var.environment}-argo-image-updater-role"
  provider_url                  = var.oidc_provider_url
  oidc_fully_qualified_subjects = ["system:serviceaccount:argo-image-updater:argocd-image-updater"]
  role_policy_arns              = [aws_iam_policy.argo_image_updater_ecr.arn]
}
