output "worker_security_group_id" {
  value = module.cluster.worker_security_group_id
}
output "cluster_primary_security_group_id" {
  value = module.cluster.cluster_primary_security_group_id
}
output "kubeconfig" {
  value = module.cluster.kubeconfig
}
output "worker_iam_role_arn" {
  value = module.cluster.worker_iam_role_arn
}
output "cluster_iam_role_arn" {
  value = module.cluster.cluster_iam_role_arn
}
output "cluster_oidc_issuer_url" {
  value = module.cluster.cluster_oidc_issuer_url
}
output "oidc_provider_arn" {
  value = module.cluster.oidc_provider_arn
}
output "kubeconfig_file" {
  value = local_file.kubeconfig.filename
}
output "cluster_id" {
  value = module.cluster.cluster_id
}
