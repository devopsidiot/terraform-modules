<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.47.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.47.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_SQS_policy_concatenation"></a> [SQS\_policy\_concatenation](#module\_SQS\_policy\_concatenation) | github.com/cloudposse/terraform-aws-iam-policy-document-aggregator | 0.8.0 |
| <a name="module_sqs"></a> [sqs](#module\_sqs) | terraform-aws-modules/sqs/aws | 3.2.1 |
| <a name="module_sqs-dead-letter"></a> [sqs-dead-letter](#module\_sqs-dead-letter) | terraform-aws-modules/sqs/aws | 3.2.1 |

## Resources

| Name | Type |
|------|------|
| [aws_sns_topic_subscription.sns_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sqs_queue_policy.sqs_queue_policy_for_sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |
| [aws_iam_policy_document.sqs_allow_messages_from_sns_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_sns_topic.sns_topic_to_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/sns_topic) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_sqs_queue_to_create"></a> [sqs\_queue\_to\_create](#input\_sqs\_queue\_to\_create) | Name of the queue to be created? Does it have any topics to subscribe to? | <pre>object(<br>    {<br>      name = string,<br>      sns_subscription = list(object(<br>        {<br>          topic_name  = string<br>          filter_policy = string<br>        }<br>      ))<br>    }<br>  )</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->