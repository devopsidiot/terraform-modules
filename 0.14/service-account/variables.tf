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
# Service Account Variables
###################################

variable "domain" {
  type        = string
  description = "Name of the domain (e.g. identity, podcast, etc)."
}

###################################
# API Key Variables
###################################

variable "cluster_id" {
  type        = string
  description = "ID of cluster."
}

variable "environment_id" {
  type        = string
  description = "ID of environment."
}

variable "schema_registry_id" {
  type        = string
  description = "ID of schema registry."
}

variable "ksqldb_id" {
  type        = string
  default     = ""
  description = "ID of ksqlDB."
}

variable "team_members" {
  type        = list(string)
  default     = []
  description = "List of team member names to create api keys for"
}

###################################
# ACL Variables
###################################

variable "owner_topic_prefixes" {
  type        = list(string)
  description = "List of topic prefixes to apply OWNER ALCs to."
  validation {
    condition = alltrue([
      for prefix in var.owner_topic_prefixes : substr(prefix, -1, 0) == "."
    ])
    error_message = "Prefix must end with a '.'."
  }
}

variable "reader_topic_prefixes" {
  type        = list(string)
  description = "List of topic prefixes to apply READER ALCs to."
  validation {
    condition = alltrue([
      for prefix in var.reader_topic_prefixes : substr(prefix, -1, 0) == "."
    ])
    error_message = "Prefix must end with a '.'."
  }
}

variable "environment" {
  type        = string
  description = "Which top-level environment is this for."
  validation {
    condition     = var.environment == "nonprod" || var.environment == "prod"
    error_message = "Environment must be one of 'nonprod' or 'prod'."
  }
}

