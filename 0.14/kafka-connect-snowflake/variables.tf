###########################
# Confluent Auth Variables
###########################

variable "username" {
  type        = string
  description = "Username for basic auth to Confluent."
}

variable "password" {
  type        = string
  description = "Password for basic auth to Confluent."
}


###############################
# Kafka Connect Auth Variables
###############################

variable "snowflake_key" {
  type        = string
  default     = ""
  description = "API Key for snowflake."
}

variable "snowflake_key_passphrase" {
  type        = string
  default     = ""
  description = "API passphrase for snowflake API key."
}

variable "kafka_api_key" {
  type        = string
  description = "API key for Kafka."
}

variable "kafka_api_secret" {
  type        = string
  description = "API secret for Kafka API key."
}

####################################
# Kafka Connect Connector Variables
####################################

variable "cluster_id" {
  type        = string
  description = "Id of the associated Kafka connect cluster."
}

variable "name" {
  type        = string
  description = "Name of the sink connector."
}

variable "topics" {
  type        = string
  description = "List of topics for the connector to be aware of."
}

variable "snowflake_url_name" {
  type        = string
  description = "URL for the snowflake connector."
}

variable "snowflake_user_name" {
  type        = string
  default     = ""
  description = "Username for the snowflake connector."
}

variable "snowflake_database_name" {
  type        = string
  default     = ""
  description = "Name of the snowflake database."
}

variable "snowflake_schema_name" {
  type        = string
  default     = ""
  description = "Name of the snowflake schema."
}

variable "max_tasks" {
  type        = string
  default     = "1"
  description = "Max number of connector tasks."
}

variable "environment_id" {
  type        = string
  description = "Id of the snowflake connector environment."
}

variable "input_data_format" {
  type        = string
  default     = "AVRO"
  description = "Format of the data in the kafka topics."
}
