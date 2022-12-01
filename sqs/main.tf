data "aws_sns_topic" "sns_topic_to_access" {
  count     = var.sqs_queue_to_create["sns_subscription"] != null ? length(var.sqs_queue_to_create["sns_subscription"]) : 0
  name = var.sqs_queue_to_create["sns_subscription"][count.index]["topic_name"]
}

module "sqs-dead-letter" {
  count   = var.sqs_queue_to_create != null ? 1 : 0
  source  = "terraform-aws-modules/sqs/aws"
  version = "3.2.1"

  name = "${var.sqs_queue_to_create["name"]}-dead-letter"
  message_retention_seconds = 1209600 #14 days
}
module "sqs" {
  count   = var.sqs_queue_to_create != null ? 1 : 0
  source  = "terraform-aws-modules/sqs/aws"
  version = "3.2.1"

  name = var.sqs_queue_to_create["name"]
  message_retention_seconds = 1209600 #14 days
  redrive_policy             = <<EOF
{
  "deadLetterTargetArn": "${module.sqs-dead-letter[0].sqs_queue_arn}",
  "maxReceiveCount": 3
}
EOF
}

data "aws_iam_policy_document" "sqs_allow_messages_from_sns_topic" {
  count     = var.sqs_queue_to_create["sns_subscription"] != null ? length(var.sqs_queue_to_create["sns_subscription"]) : 0
  
  statement {
    sid = "${count.index}"

    actions = [
      "sqs:SendMessage"
    ]

    principals {
      type = "AWS"
      identifiers = ["*"]
    }
    
    resources = [
      "${module.sqs[0].sqs_queue_arn}"
    ]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"

      values = [ "${data.aws_sns_topic.sns_topic_to_access[count.index].arn}" ]
    }
  }
}

module "SQS_policy_concatenation" {
  count = var.sqs_queue_to_create["sns_subscription"] != null ? 1 : 0
  source = "github.com/cloudposse/terraform-aws-iam-policy-document-aggregator?ref=0.8.0"
  source_documents = data.aws_iam_policy_document.sqs_allow_messages_from_sns_topic[*].json
}

resource "aws_sqs_queue_policy" "sqs_queue_policy_for_sns" {
  count = var.sqs_queue_to_create["sns_subscription"] != null ? 1 : 0
  queue_url = module.sqs[0].sqs_queue_id

  policy = module.SQS_policy_concatenation[0].result_document
}

resource "aws_sns_topic_subscription" "sns_topic" {
  count = var.sqs_queue_to_create["sns_subscription"] != null ? length(var.sqs_queue_to_create["sns_subscription"]) : 0

  topic_arn = data.aws_sns_topic.sns_topic_to_access[count.index].arn
  protocol  = "sqs"
  endpoint  = module.sqs[0].sqs_queue_arn

  filter_policy = var.sqs_queue_to_create["sns_subscription"][count.index]["filter_policy"]
}