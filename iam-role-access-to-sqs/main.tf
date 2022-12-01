data "aws_sqs_queue" "sqs_queue_to_access" {
  name = var.sqs_access["queue"]
}

data "aws_iam_policy_document" "iam_role_access_to_sqs" {
  statement {
    actions = var.sqs_access["permissions"]

    resources = [
      data.aws_sqs_queue.sqs_queue_to_access.arn
    ]
  }
}