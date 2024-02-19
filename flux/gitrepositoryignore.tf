resource "kubectl_manifest" "git_repo_ignore" {
  yaml_body  = <<YAML
apiVersion: source.toolkit.fluxcd.io/v1beta2
kind: GitRepository
metadata:
  name: flux-system
  namespace: flux-system
spec:
  interval: 1m0s
  url: https://github.com/${var.github_owner}/${var.repository_name}
  ref:
    branch: ${var.flux_branch}
  secretRef:
    name: flux-system
  timeout: 60s
  ignore: |
    ${var.workloads_directory}
YAML
  depends_on = [kubernetes_namespace.flux_system]
}
