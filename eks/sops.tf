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
      type = "AWS"
      identifiers = ["arn:aws:iam::564457638451:root"]
    }
  }
}

resource "aws_kms_key" "sops_key" {
  description         = "KMS key for SOPS encryption/decryption"
  policy              = data.aws_iam_policy_document.sops_kms.json
  enable_key_rotation = true
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_kms_alias" "sops_alias" {
  name          = "alias/sops-encryption"
  target_key_id = aws_kms_key.sops_key.key_id
  lifecycle {
    prevent_destroy = true
  }
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
  source = "decrypt.sh"
  filename        = var.decrypt_script
  file_permission = "0755"
  lifecycle {
    ignore_changes = [
      source
    ]
  }
}

resource "local_file" "encrypt_script" {
  source = "encrypt.sh"
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
