#Creation of role for eks usability
module "iam-assume-role-access-for-k8s-service-account" {
  source                 = "git@github.com:devopsidiot-ops/iam-assume-role-access-for-k8s-service-account.git?ref=v1.0.0"
  service_name           = var.service_name
  namespace              = var.namespace
  eks_cluster_attributes = var.eks_cluster_attributes
}

resource "aws_iam_role" "service-role" {
  name               = "${var.service_name}-role"
  assume_role_policy = module.iam-assume-role-access-for-k8s-service-account.policy_document
}
