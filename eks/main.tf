provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["token", "-i", module.eks.cluster_id, "-r", var.kubeconfig_role]
    command     = "aws-iam-authenticator"
  }

}
provider "null" {}

resource "tls_private_key" "eks_node_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "eks_node_key" {
  key_name   = "eks_node_${var.environment}"
  public_key = tls_private_key.eks_node_key.public_key_openssh
}

# providing key for envelope encryption
resource "aws_kms_key" "envelope_encryption" {
  description             = "EKS Secret Encryption Key"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}

resource "aws_kms_alias" "alias" {
  name          = "alias/envelope_encryption"
  target_key_id = aws_kms_key.envelope_encryption.key_id
  lifecycle {
    prevent_destroy = true
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

module "eks" {
  source                 = "terraform-aws-modules/eks/aws"
  version                = "~> 17.0" #this can't be a variable :-(
  cluster_name           = var.cluster_name
  cluster_version        = var.eks_cluster_version
  kubeconfig_output_path = join("/", [var.home_dir, var.output_file_path, "kubeconfig-${var.cluster_name}-${var.environment}.config"])
  subnets = concat(
    var.public_subnets,
    var.private_subnets
  )
  kubeconfig_name        = "${var.cluster_name}-${var.environment}"
  kubeconfig_api_version = "client.authentication.k8s.io/v1beta1"
  vpc_id                 = var.vpc_id
  #cluster_security_group_id                      = var.default_sg_id
  enable_irsa                                    = true
  cluster_endpoint_public_access                 = false
  cluster_endpoint_private_access                = true
  cluster_create_endpoint_private_access_sg_rule = true
  cluster_endpoint_private_access_cidrs          = [var.vpc_cidr]
  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]
  #have added in this encryption config to test out envelope encryption of secrets within EKS
  cluster_encryption_config = [
    {
      provider_key_arn = aws_kms_key.envelope_encryption.arn
      resources        = ["secrets"]
    }
  ]
  worker_groups = [
    {
      name                 = "karpenter-controller-node"
      subnets              = var.private_subnets
      instance_type        = "c5.xlarge"
      asg_desired_capacity = 1
    }
  ]
  worker_create_cluster_primary_security_group_rules = true
  kubeconfig_aws_authenticator_additional_args = [
    "-r",
    var.kubeconfig_role
  ]
  workers_additional_policies = [
    aws_iam_policy.AWSLoadBalancerControllerIAMPolicy.arn,
    aws_iam_policy.EKSExternalDNSPolicy.arn,
    aws_iam_policy.EKSExternalSecretsPolicy.arn,
    aws_iam_policy.ClusterAutoscalerIAMPolicy.arn
  ]
  map_roles    = var.map_roles
  map_users    = var.map_users
  map_accounts = var.map_accounts

  depends_on = [
    resource.aws_kms_key.envelope_encryption
  ]

  tags = {
    "karpenter.sh/discovery" = var.cluster_name
  }
}
#upgrading EKS CNI
resource "aws_eks_addon" "eks_cni" {
  cluster_name      = var.cluster_name
  addon_name        = "vpc-cni"
  addon_version     = "v1.11.3-eksbuild.1"
  resolve_conflicts = "OVERWRITE"
  depends_on        = [module.eks]
}
#upgrading EBS CSI driver
resource "aws_eks_addon" "aws-ebs-csi-driver" {
  cluster_name      = var.cluster_name
  addon_name        = "aws-ebs-csi-driver"
  addon_version     = "v1.10.0-eksbuild.1"
  resolve_conflicts = "OVERWRITE"
  depends_on        = [module.eks]
}
#these tags are required for kubernetes to know where its nodes live, and for the load balancer controller to function properly.
resource "aws_ec2_tag" "vpc_tag" {
  resource_id = var.vpc_id
  key         = "kubernetes.io/cluster/${var.cluster_name}"
  value       = "shared"
}

resource "aws_ec2_tag" "private_subnet_tag" {
  for_each    = toset(var.private_subnets)
  resource_id = each.value
  key         = "kubernetes.io/role/internal-elb"
  value       = "1"
}

resource "aws_ec2_tag" "private_subnet_cluster_tag" {
  for_each    = toset(var.private_subnets)
  resource_id = each.value
  key         = "kubernetes.io/cluster/${var.cluster_name}"
  value       = "shared"
}

resource "aws_ec2_tag" "private_subnet_cluster_karpenter_tag" {
  for_each    = toset(var.private_subnets)
  resource_id = each.value
  key         = "karpenter.sh/discovery"
  value       = var.cluster_name
}

resource "aws_ec2_tag" "public_subnet_tag" {
  for_each    = toset(var.public_subnets)
  resource_id = each.value
  key         = "kubernetes.io/role/elb"
  value       = "1"
}

resource "aws_ec2_tag" "public_subnet_cluster_tag" {
  for_each    = toset(var.public_subnets)
  resource_id = each.value
  key         = "kubernetes.io/cluster/${var.cluster_name}"
  value       = "shared"
}

resource "aws_s3_bucket_object" "kube_config" {
  bucket       = "devopsidiot-configs-${var.environment}"
  key          = "kubeconfig/${var.environment}-eks-kube.config"
  source       = module.eks.kubeconfig_filename
  content_type = "plain/text"
}
resource "aws_s3_bucket_object" "node_key_pub" {
  bucket       = "devopsidiot-configs-${var.environment}"
  key          = "eksnodekey/${var.environment}-eks-node-pub.pem"
  content      = tls_private_key.eks_node_key.public_key_pem
  content_type = "plain/text"
}
resource "aws_s3_bucket_object" "node_key_priv" {
  bucket       = "devopsidiot-configs-${var.environment}"
  key          = "eksnodekey/${var.environment}-eks-node-priv.pem"
  content      = tls_private_key.eks_node_key.private_key_pem
  content_type = "plain/text"
}

