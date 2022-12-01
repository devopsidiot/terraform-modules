variable "create_ecr" {
  type        = bool
  description = "Does this application need an ECR for images?"
}

variable "service_name" {
  type        = string
  description = "The name of the application"
}

variable "environment" {
  type        = string
  description = "The environment that the module is being invoked within. Used for SSM module."
}

variable "region" {
  type        = string
  description = "The region that the AWS provider will use. Used for SSM module"
}

variable "ssm_parameters" {
  type        = map(string)
  description = "A map of key value pairs that will become the keys and values created in SSM."
}

variable "sns_topic_to_create" {
  type        = list(string)
  description = "Name of the notification service(s) to be created?"
}

variable "redis_to_create" {
  type = object(
    {
      name               = string,
      cluster_size       = number,
      instance_type      = string,
      availability_zones = list(string),
      zone_name          = string,
      vpc_id             = string,
      subnets            = list(string),      
      vpc_cidr           = string
    }
  )
  default     = null
  description = "What type of Elasticache Redis Cluster does this application need?"
}

variable "sqs_queue_to_create" {
  type = object(
    {
      name             = string,
      sns_subscription = list(object(
        {
          topic_name  = string
          filter_policy = string
        }
      ))
    }
  )
  description = "Name of the notification service(s) to be created?"
  default     = null
}

variable "qldb_ledger_to_create" {
  type = string
  description = "Name of QLDB Ledger to Create"
  default = null
}

variable "rds_cluster_to_create" {
  default     = null
  description = "Does this application need to create an RDS cluster? Use this."
  type        = object(
    {
      name = string,
      namespace = string,
      environment = string,
      engine_version = string,
      instance_type = string,
      cluster_size = number,
      db_name = string,
      admin_password = string,
      kms_key_arn = string,
      rds_monitoring_interval = number,
      backup_window = string,
      retention_period = number,
      maintenance_window = string,
      vpc_id = string,
      allowed_cidr_blocks = list(string),
      subnets = list(string),
      zone_id = string,
      cluster_dns_name = string,
      reader_dns_name = string
    }
  )
}
variable "s3_bucket_to_create" {
  type = object(
    {
      bucket = string,
      object_lock_enabled = optional(bool),
      object_lock_retention_mode = optional(string),
      object_lock_years = optional(number)
    }
  )
  description = "What S3 bucket is this applicaion creating, and with what permissions?"
  default = null
}

variable "new_relic_alerts" {
  default = null
  description = "Does this application need alerts? Then create them with this."
  type = object(
    {
      newrelic_alert_policy = string,
      newrelic_alert_policy_incident_preference = string,
      newrelic_alert_email_channel_name = optional(string),
      newrelic_alert_slack_channel_name = optional(string),
      newrelic_alert_pagerduty_channel_name = optional(string),
      newrelic_alert_conditions = map(object({
        aggregation_method             = optional(string),
        aggregation_delay              = optional(number),
        aggregation_timer              = optional(number),
        aggregation_window             = optional(number),
        close_violations_on_expiration = optional(bool),
        expiration_duration            = optional(number),
        violation_time_limit_seconds   = number,
        nrql = map(object({
          query             = string,
          evaluation_offset = optional(number)
        })),
        critical = optional(map(object({
          operator              = string,
          threshold             = number,
          threshold_duration    = number,
          threshold_occurrences = string
        }))),
        warning = optional(map(object({
          operator              = string,
          threshold             = number,
          threshold_duration    = number,
          threshold_occurrences = string
        })))
      }))
    }
  )
}

variable "new_relic_dashboard" {
  default = null
  description = "Does this application need a New Relic Dashboard? Then create them with this."
  type = object(
    {
      newrelic_dashboard_name = string,
      newrelic_dashboard_permissions = string,
      newrelic_dashboard_pages = map(object({
        line_widgets = optional(map(object({
          widget_line_nrql   = string
          widget_line_column = number
          widget_line_row    = number
          widget_line_height = number
          widget_line_width  = number
        })))
        bar_widgets = optional(map(object({
          widget_bar_nrql   = string
          widget_bar_column = number
          widget_bar_row    = number
          widget_bar_height = number
          widget_bar_width  = number
        })))
        pie_widgets = optional(map(object({
          widget_pie_nrql   = string
          widget_pie_column = number
          widget_pie_row    = number
          widget_pie_height = number
          widget_pie_width  = number
        })))
        table_widgets = optional(map(object({
          widget_table_nrql   = string
          widget_table_column = number
          widget_table_row    = number
          widget_table_height = number
          widget_table_width  = number
        })))
      }))
    }
  )
}