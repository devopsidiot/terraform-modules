output "service_account_id" {
  value = confluentcloud_service_account.service_account.id
}

output "cluster_api_keys" {
  value = tomap({
    for api_key in confluentcloud_api_key.cluster_api_key : api_key.key => api_key.description
  })
}

output "cluster_api_secrets" {
  value = tomap({
    for api_key in confluentcloud_api_key.cluster_api_key : api_key.description => {
      "key" : api_key.key
      "secret" : api_key.secret,
    }
  })
  sensitive = true
}

output "schema_regsitry_api_key" {
  value = confluentcloud_api_key.schema_registry_api_key.key
}

output "schema_regsitry_api_secret" {
  value     = confluentcloud_api_key.schema_registry_api_key.secret
  sensitive = true
}

output "schema_regsitry_key_description" {
  value = confluentcloud_api_key.schema_registry_api_key.description
}

output "ksqldb_api_keys" {
  value = tomap({
    for api_key in confluentcloud_api_key.ksqlDB_api_key : api_key.key => {
      "key" : api_key.key
      "secret" : api_key.secret,
    }
  })
}

output "ksqldb_api_secret" {
  value = tomap({
    for api_key in confluentcloud_api_key.ksqlDB_api_key : api_key.key => api_key.secret
  })
  sensitive = true
}

