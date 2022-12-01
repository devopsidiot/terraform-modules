data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

#TODO: what am I used for?
data "aws_iam_policy_document" "generic_endpoint_policy" {
  statement {
    effect    = "Deny"
    actions   = ["*"]
    resources = ["*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}