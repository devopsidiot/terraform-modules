terraform {
  required_providers {
    kafka = {
      source  = "Mongey/kafka"
      version = "0.3.3"
    }
  }
}


provider "kafka" {
  bootstrap_servers = var.bootstrap_servers
  sasl_username     = var.api_key
  sasl_password     = var.api_secret
  sasl_mechanism    = "plain"
}

resource "kafka_topic" "kafka_topic" {
  name               = var.topic_name
  replication_factor = var.replication_factor
  partitions         = var.partitions
  config = {
    "cleanup.policy"                        = var.cleanup_policy
    "confluent.key.schema.validation"       = var.confluent_key_schema_validation
    "confluent.key.subject.name.strategy"   = var.confluent_key_subject_name_strategy
    "confluent.value.schema.validation"     = var.confluent_value_schema_validation
    "confluent.value.subject.name.strategy" = var.confluent_value_subject_name_strategy
    "delete.retention.ms"                   = var.delete_retention_ms
    "max.compaction.lag.ms"                 = var.max_compaction_lag_ms
    "max.message.bytes"                     = var.max_message_bytes
    "message.timestamp.difference.max.ms"   = var.message_timestamp_difference_max_ms
    "message.timestamp.type"                = var.message_timestamp_type
    "min.compaction.lag.ms"                 = var.min_compaction_lag_ms
    "min.insync.replicas"                   = var.min_insync_replicas
    "retention.bytes"                       = var.retention_bytes
    "retention.ms"                          = var.retention_ms
    "segment.bytes"                         = var.segment_bytes
    "segment.ms"                            = var.segment_ms
  }
}
