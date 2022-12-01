<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecr"></a> [ecr](#module\_ecr) | git@github.com:devopsidiot-ops/ecr.git | v1.0.0 |
| <a name="module_elasticache_redis_cluster"></a> [elasticache\_redis\_cluster](#module\_elasticache\_redis\_cluster) | git@github.com:devopsidiot-ops/elasticache-redis-cluster.git | v1.0.0 |
| <a name="module_new-relic-alerts"></a> [new-relic-alerts](#module\_new-relic-alerts) | git@github.com:devopsidiot-ops/new-relic-alerts.git | v1.2.1 |
| <a name="module_new-relic-dashboard"></a> [new-relic-dashboard](#module\_new-relic-dashboard) | git@github.com:devopsidiot-ops/new-relic-one-dashboard.git | v1.0.2 |
| <a name="module_rds"></a> [rds](#module\_rds) | git@github.com:devopsidiot-ops/rds-cluster.git | v1.0.0 |
| <a name="module_sns"></a> [sns](#module\_sns) | terraform-aws-modules/sns/aws | 3.3.0 |
| <a name="module_sqs"></a> [sqs](#module\_sqs) | git@github.com:devopsidiot-ops/sqs.git | v1.0.0 |
| <a name="module_ssm"></a> [ssm](#module\_ssm) | git@github.com:devopsidiot-ops/ssm.git | v1.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_qldb_ledger.qldb_ledger_to_create](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/qldb_ledger) | resource |
| [aws_s3_bucket.s3_bucket_to_create](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_ecr"></a> [create\_ecr](#input\_create\_ecr) | Does this application need an ECR for images? | `bool` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment that the module is being invoked within. Used for SSM module. | `string` | n/a | yes |
| <a name="input_new_relic_alerts"></a> [new\_relic\_alerts](#input\_new\_relic\_alerts) | Does this application need alerts? Then create them with this. | <pre>object(<br>    {<br>      newrelic_alert_policy = string,<br>      newrelic_alert_policy_incident_preference = string,<br>      newrelic_alert_email_channel_name = optional(string),<br>      newrelic_alert_slack_channel_name = optional(string),<br>      newrelic_alert_pagerduty_channel_name = optional(string),<br>      newrelic_alert_conditions = map(object({<br>        aggregation_method             = optional(string),<br>        aggregation_delay              = optional(number),<br>        aggregation_timer              = optional(number),<br>        aggregation_window             = optional(number),<br>        close_violations_on_expiration = optional(bool),<br>        expiration_duration            = optional(number),<br>        violation_time_limit_seconds   = number,<br>        nrql = map(object({<br>          query             = string,<br>          evaluation_offset = optional(number)<br>        })),<br>        critical = optional(map(object({<br>          operator              = string,<br>          threshold             = number,<br>          threshold_duration    = number,<br>          threshold_occurrences = string<br>        }))),<br>        warning = optional(map(object({<br>          operator              = string,<br>          threshold             = number,<br>          threshold_duration    = number,<br>          threshold_occurrences = string<br>        })))<br>      }))<br>    }<br>  )</pre> | `null` | no |
| <a name="input_new_relic_dashboard"></a> [new\_relic\_dashboard](#input\_new\_relic\_dashboard) | Does this application need a New Relic Dashboard? Then create them with this. | <pre>object(<br>    {<br>      newrelic_dashboard_name = string,<br>      newrelic_dashboard_permissions = string,<br>      newrelic_dashboard_pages = map(object({<br>        line_widgets = optional(map(object({<br>          widget_line_nrql   = string<br>          widget_line_column = number<br>          widget_line_row    = number<br>          widget_line_height = number<br>          widget_line_width  = number<br>        })))<br>        bar_widgets = optional(map(object({<br>          widget_bar_nrql   = string<br>          widget_bar_column = number<br>          widget_bar_row    = number<br>          widget_bar_height = number<br>          widget_bar_width  = number<br>        })))<br>        pie_widgets = optional(map(object({<br>          widget_pie_nrql   = string<br>          widget_pie_column = number<br>          widget_pie_row    = number<br>          widget_pie_height = number<br>          widget_pie_width  = number<br>        })))<br>        table_widgets = optional(map(object({<br>          widget_table_nrql   = string<br>          widget_table_column = number<br>          widget_table_row    = number<br>          widget_table_height = number<br>          widget_table_width  = number<br>        })))<br>      }))<br>    }<br>  )</pre> | `null` | no |
| <a name="input_qldb_ledger_to_create"></a> [qldb\_ledger\_to\_create](#input\_qldb\_ledger\_to\_create) | Name of QLDB Ledger to Create | `string` | `null` | no |
| <a name="input_rds_cluster_to_create"></a> [rds\_cluster\_to\_create](#input\_rds\_cluster\_to\_create) | Does this application need to create an RDS cluster? Use this. | <pre>object(<br>    {<br>      name = string,<br>      namespace = string,<br>      environment = string,<br>      engine_version = string,<br>      instance_type = string,<br>      cluster_size = number,<br>      db_name = string,<br>      admin_password = string,<br>      kms_key_arn = string,<br>      rds_monitoring_interval = number,<br>      backup_window = string,<br>      retention_period = number,<br>      maintenance_window = string,<br>      vpc_id = string,<br>      allowed_cidr_blocks = list(string),<br>      subnets = list(string),<br>      zone_id = string,<br>      cluster_dns_name = string,<br>      reader_dns_name = string<br>    }<br>  )</pre> | `null` | no |
| <a name="input_redis_to_create"></a> [redis\_to\_create](#input\_redis\_to\_create) | What type of Elasticache Redis Cluster does this application need? | <pre>object(<br>    {<br>      name               = string,<br>      cluster_size       = number,<br>      instance_type      = string,<br>      availability_zones = list(string),<br>      zone_name          = string,<br>      vpc_id             = string,<br>      subnets            = list(string),      <br>      vpc_cidr           = string<br>    }<br>  )</pre> | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | The region that the AWS provider will use. Used for SSM module | `string` | n/a | yes |
| <a name="input_s3_bucket_to_create"></a> [s3\_bucket\_to\_create](#input\_s3\_bucket\_to\_create) | What S3 bucket is this applicaion creating, and with what permissions? | <pre>object(<br>    {<br>      bucket = string,<br>      object_lock_enabled = optional(bool),<br>      object_lock_retention_mode = optional(string),<br>      object_lock_years = optional(number)<br>    }<br>  )</pre> | `null` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | The name of the application | `string` | n/a | yes |
| <a name="input_sns_topic_to_create"></a> [sns\_topic\_to\_create](#input\_sns\_topic\_to\_create) | Name of the notification service(s) to be created? | `list(string)` | n/a | yes |
| <a name="input_sqs_queue_to_create"></a> [sqs\_queue\_to\_create](#input\_sqs\_queue\_to\_create) | Name of the notification service(s) to be created? | <pre>object(<br>    {<br>      name             = string,<br>      sns_subscription = list(object(<br>        {<br>          topic_name  = string<br>          filter_policy = string<br>        }<br>      ))<br>    }<br>  )</pre> | `null` | no |
| <a name="input_ssm_parameters"></a> [ssm\_parameters](#input\_ssm\_parameters) | A map of key value pairs that will become the keys and values created in SSM. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_created_qldb_ledger"></a> [created\_qldb\_ledger](#output\_created\_qldb\_ledger) | QLDB Ledger created for this application |
| <a name="output_created_rds"></a> [created\_rds](#output\_created\_rds) | Aurora PostgreSQL Cluster created for this application |
| <a name="output_created_redis"></a> [created\_redis](#output\_created\_redis) | Elasticache Redis cluster created for this application |
| <a name="output_created_s3_bucket"></a> [created\_s3\_bucket](#output\_created\_s3\_bucket) | S3 bucket created for this application |
| <a name="output_created_sns"></a> [created\_sns](#output\_created\_sns) | SNS(s) created for this application |
| <a name="output_created_sqs"></a> [created\_sqs](#output\_created\_sqs) | SQS created for this application |
<!-- END_TF_DOCS -->