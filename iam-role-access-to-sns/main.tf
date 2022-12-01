data "aws_sns_topic" "sns_topic_to_access" {
  name = var.sns_access["topic"]
}

data "aws_iam_policy_document" "iam_role_access_to_sns" {
  statement {
    actions = var.sns_access["permissions"]

    resources = [
      data.aws_sns_topic.sns_topic_to_access.arn
    ]
  }
}
