terraform {
  required_providers {
    confluentcloud = {
      source = "Mongey/confluentcloud"
    }
  }
}

provider "confluentcloud" {
  username = var.username
  password = var.password
}

resource "confluentcloud_connector" "snowflake_sink_connector" {
  name           = var.name
  environment_id = var.environment_id
  cluster_id     = var.cluster_id
  config = {
    "name"                             = var.name
    "connector.class"                  = "SnowflakeSink"
    "topics"                           = var.topics
    "snowflake.url.name"               = var.snowflake_url_name
    "snowflake.user.name"              = var.snowflake_user_name
    "snowflake.database.name"          = var.snowflake_database_name
    "snowflake.schema.name"            = var.snowflake_schema_name
    "tasks.max"                        = var.max_tasks
    "input.data.format"                = var.input_data_format
    "kafka.api.key"                    = var.kafka_api_key
    "kafka.api.secret"                 = var.kafka_api_secret
    "snowflake.private.key"            = var.snowflake_key
    "snowflake.private.key.passphrase" = var.snowflake_key_passphrase
  }
}
