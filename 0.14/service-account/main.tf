terraform {
  required_providers {
    confluentcloud = {
      source = "Mongey/confluentcloud"
    }
    kafka = {
      source = "Mongey/kafka"
    }
  }
}


provider "confluentcloud" {
  username = var.username
  password = var.password
}

provider "kafka" {
  bootstrap_servers = var.bootstrap_servers
  sasl_username     = var.api_key
  sasl_password     = var.api_secret
  sasl_mechanism    = "plain"
}

locals {
  consumer_groups = toset(["KMagic-", "console-", "connect-", "${var.domain}-"])
  api_keys        = concat([var.domain], var.team_members)

  reader_topic_prefixes_with_env = [
    for topic_prefix in var.reader_topic_prefixes : "${topic_prefix}${var.environment}"
  ]
}

resource "confluentcloud_service_account" "service_account" {
  name        = "${var.domain}-team"
  description = "Service account for ${var.domain} team"
}

resource "confluentcloud_api_key" "cluster_api_key" {
  for_each = toset(local.api_keys)

  cluster_id     = var.cluster_id
  environment_id = var.environment_id
  description    = "API Key for ${each.key} in domain ${var.domain}"
  user_id        = confluentcloud_service_account.service_account.id

  depends_on = [confluentcloud_service_account.service_account]
}

resource "confluentcloud_api_key" "schema_registry_api_key" {
  logical_clusters = [
    var.schema_registry_id
  ]
  environment_id = var.environment_id
  description    = "Schema Registry API Key for domain ${var.domain}"
  user_id        = confluentcloud_service_account.service_account.id

  depends_on = [confluentcloud_service_account.service_account]
}

resource "confluentcloud_api_key" "ksqlDB_api_key" {
  logical_clusters = [
    var.ksqldb_id
  ]
  count          = var.ksqldb_id != "" ? 1 : 0
  environment_id = var.environment_id
  description    = "ksqlDB API Key for domain ${var.domain}"
  user_id        = confluentcloud_service_account.service_account.id

  depends_on = [confluentcloud_service_account.service_account]
}

resource "kafka_acl" "allow_read_acl" {
  for_each = toset(concat(var.owner_topic_prefixes, var.reader_topic_prefixes))

  resource_name                = each.key
  resource_type                = "Topic"
  acl_principal                = "User:${confluentcloud_service_account.service_account.id}"
  acl_host                     = "*"
  acl_operation                = "Read"
  acl_permission_type          = "Allow"
  resource_pattern_type_filter = "Prefixed"

  depends_on = [confluentcloud_service_account.service_account]
}

resource "kafka_acl" "allow_write_acl" {
  for_each = toset(concat(var.owner_topic_prefixes, var.reader_topic_prefixes))

  resource_name                = each.key
  resource_type                = "Topic"
  acl_principal                = "User:${confluentcloud_service_account.service_account.id}"
  acl_host                     = "*"
  acl_operation                = "Write"
  acl_permission_type          = "Allow"
  resource_pattern_type_filter = "Prefixed"

  depends_on = [confluentcloud_service_account.service_account]
}

resource "kafka_acl" "allow_describe_acl" {
  for_each = toset(concat(var.owner_topic_prefixes, var.reader_topic_prefixes))

  resource_name                = each.key
  resource_type                = "Topic"
  acl_principal                = "User:${confluentcloud_service_account.service_account.id}"
  acl_host                     = "*"
  acl_operation                = "Describe"
  acl_permission_type          = "Allow"
  resource_pattern_type_filter = "Prefixed"

  depends_on = [confluentcloud_service_account.service_account]
}

resource "kafka_acl" "allow_describe_configs_acl" {
  for_each = toset(concat(var.owner_topic_prefixes, var.reader_topic_prefixes))

  resource_name                = each.key
  resource_type                = "Topic"
  acl_principal                = "User:${confluentcloud_service_account.service_account.id}"
  acl_host                     = "*"
  acl_operation                = "DescribeConfigs"
  acl_permission_type          = "Allow"
  resource_pattern_type_filter = "Prefixed"

  depends_on = [confluentcloud_service_account.service_account]
}

resource "kafka_acl" "allow_create_acl" {
  for_each = toset(var.owner_topic_prefixes)

  resource_name                = each.key
  resource_type                = "Topic"
  acl_principal                = "User:${confluentcloud_service_account.service_account.id}"
  acl_host                     = "*"
  acl_operation                = "Create"
  acl_permission_type          = "Allow"
  resource_pattern_type_filter = "Prefixed"

  depends_on = [confluentcloud_service_account.service_account]
}

resource "kafka_acl" "deny_write_acl" {
  for_each = toset(local.reader_topic_prefixes_with_env)

  resource_name                = each.key
  resource_type                = "Topic"
  acl_principal                = "User:${confluentcloud_service_account.service_account.id}"
  acl_host                     = "*"
  acl_operation                = "Write"
  acl_permission_type          = "Deny"
  resource_pattern_type_filter = "Prefixed"

  depends_on = [confluentcloud_service_account.service_account]
}

resource "kafka_acl" "consumer_group_acl" {
  for_each = local.consumer_groups

  resource_name                = each.key
  resource_type                = "Group"
  acl_principal                = "User:${confluentcloud_service_account.service_account.id}"
  acl_host                     = "*"
  acl_operation                = "Read"
  acl_permission_type          = "Allow"
  resource_pattern_type_filter = "Prefixed"

  depends_on = [confluentcloud_service_account.service_account]
}


