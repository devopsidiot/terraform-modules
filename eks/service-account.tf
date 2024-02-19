# Create a namespace where legacy API pods will be launched
resource "kubernetes_namespace" "api-namespace" {
  count = length(var.api_namespaces)
  metadata {

    labels = {
      name = var.api_namespaces[count.index]
    }

    name = var.api_namespaces[count.index]
  }

  depends_on = [
    module.eks
  ]
}

# Create Service Account for legacy API
module "kubernetes-iamserviceaccount" {
  count                = length(var.api_namespaces)
  depends_on           = [kubernetes_namespace.api-namespace]
  source               = "bigdatabr/kubernetes-iamserviceaccount/aws"
  version              = "1.1.0"
  cluster_name         = var.cluster_name
  namespace            = var.api_namespaces[count.index]
  role_name            = "api-service-account-role-${var.api_namespaces[count.index]}-${var.environment}"
  service_account_name = "api-service-account-${var.environment}"
}

# Legacy API policies are still managed in the legacy terraform repo
resource "aws_iam_role_policy_attachment" "service-account-policy-attachment-allow" {
  count      = length(var.api_namespaces)
  depends_on = [module.kubernetes-iamserviceaccount]
  role       = "api-service-account-role-${var.api_namespaces[count.index]}-${var.environment}"
  policy_arn = var.api_namespaces != "dev" && var.api_namespaces != "stg" && var.api_namespaces != "prd" ? "arn:aws:iam::${var.account_id}:policy/glorify-api-user-policy-allow-dev" : "arn:aws:iam::${var.account_id}:policy/glorify-api-user-policy-allow-${var.api_namespaces[count.index]}"
}

resource "aws_iam_role_policy_attachment" "service-account-policy-attachment-deny" {
  count      = length(var.api_namespaces)
  depends_on = [module.kubernetes-iamserviceaccount]
  role       = "api-service-account-role-${var.api_namespaces[count.index]}-${var.environment}"
  policy_arn = var.api_namespaces != "dev" && var.api_namespaces != "stg" && var.api_namespaces != "prd" ? "arn:aws:iam::${var.account_id}:policy/glorify-api-user-policy-deny-dev" : "arn:aws:iam::${var.account_id}:policy/glorify-api-user-policy-deny-${var.api_namespaces[count.index]}"
}
