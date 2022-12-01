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
| <a name="module_resource-builder"></a> [resource-builder](#module\_resource-builder) | ./modules/resource-builder | n/a |
| <a name="module_role-producer"></a> [role-producer](#module\_role-producer) | ./modules/role-producer | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ssm_parameter.newrelic_account_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.newrelic_api_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_ecr"></a> [create\_ecr](#input\_create\_ecr) | Does this application need an ECR for images? | `bool` | `false` | no |
| <a name="input_create_role"></a> [create\_role](#input\_create\_role) | Does this application need an IAM role? | `bool` | `false` | no |
| <a name="input_eks_cluster_attributes"></a> [eks\_cluster\_attributes](#input\_eks\_cluster\_attributes) | EKS Cluster attributes to be pulled from EKS module attributes | <pre>object(<br>    {<br>      cluster_oidc_issuer_url = string,<br>      oidc_provider_arn       = string,<br>    }<br>  )</pre> | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The kubernetes namespace this application will reside in | `string` | `"devopsidiot"` | no |
| <a name="input_new_relic_alerts"></a> [new\_relic\_alerts](#input\_new\_relic\_alerts) | Does this application need alerts? Then create them with this. | <pre>object(<br>    {<br>      newrelic_alert_policy = string,<br>      newrelic_alert_policy_incident_preference = string,<br>      newrelic_alert_email_channel_name = optional(string),<br>      newrelic_alert_slack_channel_name = optional(string),<br>      newrelic_alert_pagerduty_channel_name = optional(string),<br>      newrelic_alert_conditions = map(object({<br>        aggregation_method             = optional(string),<br>        aggregation_delay              = optional(number),<br>        aggregation_timer              = optional(number),<br>        aggregation_window             = optional(number),<br>        close_violations_on_expiration = optional(bool),<br>        expiration_duration            = optional(number),<br>        violation_time_limit_seconds   = number,<br>        nrql = map(object({<br>          query             = string,<br>          evaluation_offset = optional(number)<br>        })),<br>        critical = optional(map(object({<br>          operator              = string,<br>          threshold             = number,<br>          threshold_duration    = number,<br>          threshold_occurrences = string<br>        }))),<br>        warning = optional(map(object({<br>          operator              = string,<br>          threshold             = number,<br>          threshold_duration    = number,<br>          threshold_occurrences = string<br>        })))<br>      }))<br>    }<br>  )</pre> | `null` | no |
| <a name="input_new_relic_dashboard"></a> [new\_relic\_dashboard](#input\_new\_relic\_dashboard) | Does this application need a New Relic Dashboard? Then create them with this. | <pre>object(<br>    {<br>      newrelic_dashboard_name = string,<br>      newrelic_dashboard_permissions = string,<br>      newrelic_dashboard_pages = map(object({<br>        line_widgets = optional(map(object({<br>          widget_line_nrql   = string<br>          widget_line_column = number<br>          widget_line_row    = number<br>          widget_line_height = number<br>          widget_line_width  = number<br>        })))<br>        bar_widgets = optional(map(object({<br>          widget_bar_nrql   = string<br>          widget_bar_column = number<br>          widget_bar_row    = number<br>          widget_bar_height = number<br>          widget_bar_width  = number<br>        })))<br>        pie_widgets = optional(map(object({<br>          widget_pie_nrql   = string<br>          widget_pie_column = number<br>          widget_pie_row    = number<br>          widget_pie_height = number<br>          widget_pie_width  = number<br>        })))<br>        table_widgets = optional(map(object({<br>          widget_table_nrql   = string<br>          widget_table_column = number<br>          widget_table_row    = number<br>          widget_table_height = number<br>          widget_table_width  = number<br>        })))<br>      }))<br>    }<br>  )</pre> | `null` | no |
| <a name="input_qldb_ledger_to_create"></a> [qldb\_ledger\_to\_create](#input\_qldb\_ledger\_to\_create) | Name of QLDB Ledger to Create | `string` | `null` | no |
| <a name="input_rds_cluster_to_create"></a> [rds\_cluster\_to\_create](#input\_rds\_cluster\_to\_create) | Does this application need to create an RDS cluster? Use this. | <pre>object(<br>    {<br>      name = string,<br>      namespace = string,<br>      environment = string,<br>      engine_version = string,<br>      instance_type = string,<br>      cluster_size = number,<br>      db_name = string,<br>      admin_password = string,<br>      kms_key_arn = string,<br>      rds_monitoring_interval = number,<br>      backup_window = string,<br>      retention_period = number,<br>      maintenance_window = string,<br>      vpc_id = string,<br>      allowed_cidr_blocks = list(string),<br>      subnets = list(string),<br>      zone_id = string,<br>      cluster_dns_name = string,<br>      reader_dns_name = string<br>    }<br>  )</pre> | `null` | no |
| <a name="input_redis_to_create"></a> [redis\_to\_create](#input\_redis\_to\_create) | What type of Elasticache Redis Cluster does this application need? | <pre>object(<br>    {<br>      name               = string,<br>      cluster_size       = number,<br>      instance_type      = string,<br>      availability_zones = list(string),<br>      zone_name          = string,<br>      vpc_id             = string,<br>      subnets            = list(string),      <br>      vpc_cidr           = string<br>    }<br>  )</pre> | `null` | no |
| <a name="input_s3_bucket_to_create"></a> [s3\_bucket\_to\_create](#input\_s3\_bucket\_to\_create) | What S3 bucket is this applicaion creating, and with what permissions? | <pre>object(<br>    {<br>      bucket = string,<br>      object_lock_enabled = optional(bool),<br>      object_lock_retention_mode = optional(string),<br>      object_lock_years = optional(number)<br>    }<br>  )</pre> | `null` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | The name of the application | `string` | n/a | yes |
| <a name="input_shared_qldb_access"></a> [shared\_qldb\_access](#input\_shared\_qldb\_access) | Which QLDB Ledger does this application need access to? | `string` | `null` | no |
| <a name="input_shared_rds_access"></a> [shared\_rds\_access](#input\_shared\_rds\_access) | RDS Cluster attributes to give IAM role access to | <pre>object(<br>    {<br>      rds_cluster_name    = string,<br>      rds_cluster_account = string,<br>      rds_cluster_region  = string,<br>      rds_user_name       = string<br>    }<br>  )</pre> | `null` | no |
| <a name="input_shared_s3_access"></a> [shared\_s3\_access](#input\_shared\_s3\_access) | What S3 bucket does this applicaion need access to? | <pre>object(<br>    {<br>      bucket       = string,<br>      permissions = set(string)<br>    }<br>  )</pre> | `null` | no |
| <a name="input_shared_sns_access"></a> [shared\_sns\_access](#input\_shared\_sns\_access) | Which SNS topic does this application need access to, and with what permissions? | <pre>object(<br>    {<br>      topic       = string,<br>      permissions = set(string)<br>    }<br>  )</pre> | `null` | no |
| <a name="input_sns_topic_to_create"></a> [sns\_topic\_to\_create](#input\_sns\_topic\_to\_create) | Name of the notification service(s) to be created? | `list(string)` | `null` | no |
| <a name="input_sqs_queue_to_create"></a> [sqs\_queue\_to\_create](#input\_sqs\_queue\_to\_create) | Name of the notification service to be created, and topics to subscribe to? | <pre>object(<br>    {<br>      name             = string,<br>      sns_subscription = list(object(<br>        {<br>          topic_name  = string<br>          filter_policy = string<br>        }<br>      ))<br>    }<br>  )</pre> | `null` | no |
| <a name="input_ssm_parameters"></a> [ssm\_parameters](#input\_ssm\_parameters) | A map of key value pairs that will become the keys and values created in SSM. | `map(string)` | `null` | no |
| <a name="input_ssm_scopes"></a> [ssm\_scopes](#input\_ssm\_scopes) | What ssm parameter paths should this application have access to? | `set(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_created_rds"></a> [created\_rds](#output\_created\_rds) | Aurora PostgreSQL Cluster created for this application |
| <a name="output_created_redis"></a> [created\_redis](#output\_created\_redis) | Elasticache Redis cluster created for this application |
| <a name="output_created_sns"></a> [created\_sns](#output\_created\_sns) | SNS created for this application |
| <a name="output_created_sqs"></a> [created\_sqs](#output\_created\_sqs) | SQS created for this application |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | IAM Role created by role producer |
<!-- END_TF_DOCS -->