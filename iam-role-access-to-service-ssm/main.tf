data "aws_kms_key" "ssm_key" {
  key_id = "alias/parameter_store_key"
}

module "IAM_role_access_to_service_ssm" {
  source = "github.com/cloudposse/terraform-aws-iam-policy-document-aggregator?ref=0.8.0"
  source_documents = concat([
    data.aws_iam_policy_document.iam_role_access_to_describe_ssm_parameters.json,
    data.aws_iam_policy_document.iam_role_access_to_ssm_key.json,
    ],
    tolist([for v in data.aws_iam_policy_document.iam_role_access_to_service_ssm : v.json])
  )
}

data "aws_iam_policy_document" "iam_role_access_to_service_ssm" {
  for_each = var.ssm_scopes
  statement {
    actions = [
      "ssm:GetParameters*"
    ]

    resources = [
      "arn:aws:ssm:*:*:parameter/${each.key}"
    ]
  }
}

data "aws_iam_policy_document" "iam_role_access_to_describe_ssm_parameters" {
  statement {
    actions = [
      "ssm:DescribeParameters"
    ]

    resources = [
      "arn:aws:ssm:*:*:*"
    ]
  }
}

data "aws_iam_policy_document" "iam_role_access_to_ssm_key" {
  statement {
    actions = [
      "kms:ListKeys",
      "kms:Describe*",
      "kms:Decrypt"
    ]

    resources = [
      data.aws_kms_key.ssm_key.arn
    ]
  }
}
