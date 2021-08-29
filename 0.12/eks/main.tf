data "aws_eks_cluster" "cluster" {
  name = module.cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.cluster.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.9"
}

module "cluster" {
  source                                       = "terraform-aws-modules/eks/aws"
  version                                      = "12.2.0"
  cluster_name                                 = var.name
  cluster_version                              = var.cluster_version
  subnets                                      = var.subnet_ids
  vpc_id                                       = var.vpc_id
  cluster_endpoint_private_access              = var.cluster_endpoint_private_access
  cluster_endpoint_public_access               = var.cluster_endpoint_public_access
  cluster_endpoint_private_access_cidrs        = var.cluster_endpoint_private_access_cidrs
  cluster_enabled_log_types                    = var.cluster_enabled_log_types
  cluster_log_retention_in_days                = var.cluster_log_retention_in_days
  tags                                         = var.tags
  map_roles                                    = var.map_roles
  map_users                                    = var.map_users
  node_groups                                  = var.node_groups
  node_groups_defaults                         = var.node_groups_defaults
  workers_additional_policies                  = var.workers_additional_policies
  # Supported input, but not yet supported by AWS
  # worker_additional_security_group_ids         = var.worker_additional_security_group_ids
  kubeconfig_aws_authenticator_additional_args = var.kubeconfig_aws_authenticator_additional_args
  enable_irsa                                  = var.enable_irsa
}

resource "local_file" "kubeconfig" {
  content  = module.cluster.kubeconfig 
  filename = var.kubeconfig_file
  file_permission = "0600"
}
