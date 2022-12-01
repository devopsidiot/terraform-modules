data "aws_kms_alias" "kms_alias" {
  name = var.kms_alias
}
resource "aws_ssm_parameter" "parameters" {
  for_each    = var.ssm_parameters
  name        = each.key
  description = "${each.key} ${var.environment}"
  type        = "SecureString"
  overwrite   = false
  value       = each.value
  key_id      = data.aws_kms_alias.kms_alias.target_key_arn
  lifecycle {
    ignore_changes = [
      value,
      description,
      tags,
      key_id
    ]
  }
}
