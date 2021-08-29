###########################
# Kafka Auth Variables
###########################

variable "api_key" {
  type        = string
  description = "API Key for auth to Kafka Cluster."
}

variable "api_secret" {
  type        = string
  description = "API Secret for auth to Kafka Cluster."
}

variable "bootstrap_servers" {
  type        = list(string)
  description = "URL to connect to Kafka Cluster."
}


###################################
# Kafka Topic Required Variables
###################################

variable "topic_name" {
  type        = string
  description = "Name of topic to create."
}

variable "replication_factor" {
  type        = string
  default     = "3"
  description = "Number of replicas for the topic."
}

variable "partitions" {
  type        = string
  default     = "10"
  description = "Number of partitions for the topic."
}


####################################
# Kafka Topic Config Variables.
#!!DO NOT MODIFY THE DEFAULTS!!
####################################

variable "cleanup_policy" {
  type        = string
  default     = "delete"
  description = "A string that is either 'delete' or 'compact' or both. This string designates the retention policy to use on old log segments. The default policy ('delete') will discard old segments when their retention time or size limit has been reached. The 'compact' setting will enable log compaction on the topic."
}

variable "confluent_key_schema_validation" {
  type        = string
  default     = "false"
  description = "A string that is either 'true' or 'false'. If confluent brokers enforce key schema at the broker level."
}

variable "confluent_key_subject_name_strategy" {
  type        = string
  default     = "io.confluent.kafka.serializers.subject.TopicNameStrategy"
  description = ""
}

variable "confluent_value_schema_validation" {
  type        = string
  default     = "false"
  description = "A string that is either 'true' or 'false'. If confluent brokers enforce value schema at the broker level."
}

variable "confluent_value_subject_name_strategy" {
  type        = string
  default     = "io.confluent.kafka.serializers.subject.TopicNameStrategy"
  description = ""
}

variable "delete_retention_ms" {
  type        = string
  default     = "86400000"
  description = ""
}

variable "max_compaction_lag_ms" {
  type        = string
  default     = "9223372036854775807"
  description = ""
}

variable "max_message_bytes" {
  type        = string
  default     = "2097164"
  description = ""
}

variable "message_timestamp_difference_max_ms" {
  type        = string
  default     = "9223372036854775807"
  description = ""
}

variable "message_timestamp_type" {
  type        = string
  default     = "CreateTime"
  description = ""
}

variable "min_compaction_lag_ms" {
  type        = string
  default     = "0"
  description = ""
}

variable "min_insync_replicas" {
  type        = string
  default     = "2"
  description = ""
}

variable "retention_bytes" {
  type        = string
  default     = "-1"
  description = ""
}

variable "retention_ms" {
  type        = string
  default     = "604800000"
  description = ""
}

variable "segment_bytes" {
  type        = string
  default     = "104857600"
  description = ""
}

variable "segment_ms" {
  type        = string
  default     = "604800000"
  description = ""
}
