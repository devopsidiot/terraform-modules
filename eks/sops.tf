
data "aws_iam_policy_document" "sops_policy" {
  statement {
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }
  statement {
    actions   = ["kms:Decrypt"]
    resources = ["*"]
  }
}

data "aws_iam_policy" "ec2_registry_ro" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_policy" "sops_policy" {
  name        = "${var.environment}-sops-policy"
  description = "Policy for sops decryption within EKS cluster"
  policy      = data.aws_iam_policy_document.sops_policy.json
}

module "sops_iam_role" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version                       = "4.7.0"
  role_name                     = "${var.environment}-sops-oidc-role"
  create_role                   = true
  provider_urls                 = [module.eks.cluster_oidc_issuer_url]
  oidc_fully_qualified_subjects = ["system:serviceaccount:flux-system:kustomize-controller"]
  role_policy_arns              = concat([aws_iam_policy.sops_policy.arn, data.aws_iam_policy.ec2_registry_ro.arn])
  number_of_role_policy_arns    = 2

  depends_on = [
    module.eks
  ]
}
# SOPS KMS stuff
data "aws_iam_policy_document" "sops_kms" {
  statement {
    actions   = ["kms:*"]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.account_id}:role/admin"]
    }
  }
  statement {
    actions   = ["kms:Decrypt"]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = [module.sops_iam_role.iam_role_arn]
    }
  }
  statement {
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::174950171951:root"]
    }
  }
}

resource "aws_kms_key" "sops_key" {
  description         = "KMS key for SOPS encryption/decryption"
  policy              = data.aws_iam_policy_document.sops_kms.json
  enable_key_rotation = true
}

resource "aws_kms_alias" "sops_alias" {
  name          = "alias/${var.environment}-sops-encryption"
  target_key_id = aws_kms_key.sops_key.key_id
}

resource "local_file" "sops_file" {
  content         = <<EOF
creation_rules:
  - kms: "${aws_kms_key.sops_key.arn}"
EOF
  filename        = var.sops_file
  file_permission = "0600"
}

resource "local_file" "decrypt_script" {
  source          = "decrypt.sh"
  filename        = var.decrypt_script
  file_permission = "0755"
  lifecycle {
    ignore_changes = [
      source
    ]
  }
}

resource "local_file" "encrypt_script" {
  source          = "encrypt.sh"
  filename        = var.encrypt_script
  file_permission = "0755"
  lifecycle {
    ignore_changes = [
      source
    ]
  }
}

resource "local_file" "shared-parameters" {
  content         = <<EOF
argocd_clientid:
argocd_clientsecret:
github_pat:
github_ssh:
newrelic_ingest-key:
newrelic_insights-insert-key:
newrelic_api-key:
EOF
  filename        = var.shared_parameters_yaml
  file_permission = "0644"
  lifecycle {
    ignore_changes = [
      content
    ]
  }
}

resource "local_file" "gitignore" {
  content         = <<EOF
shared-parameters.decrypted.yaml
EOF
  filename        = var.gitignore
  file_permission = "0644"
}
