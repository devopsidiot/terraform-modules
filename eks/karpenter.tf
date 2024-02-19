data "aws_iam_policy_document" "karpenter_controller" {
  statement {
    actions = [
      "ec2:CreateLaunchTemplate",
      "ec2:CreateFleet",
      "ec2:RunInstances",
      "ec2:DeleteLaunchTemplate",
      "ec2:CreateTags",
      "iam:PassRole",
      "ec2:TerminateInstances",
      "ec2:DescribeLaunchTemplates",
      "ec2:DeleteLaunchTemplate",
      "ec2:DescribeInstances",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeInstanceTypes",
      "ec2:DescribeInstanceTypeOfferings",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeImages",
      "ec2:DescribeSpotPriceHistory",
      "pricing:GetProducts",
      "ssm:GetParameter"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy" "ssm_managed_instance" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "karpenter_ssm_policy" {
  role       = module.eks.worker_iam_role_name
  policy_arn = data.aws_iam_policy.ssm_managed_instance.arn
}

data "http" "karpenter_crd_provisioners" {
  url = "https://raw.githubusercontent.com/aws/karpenter/v0.16.0/charts/karpenter/crds/karpenter.sh_provisioners.yaml"
}

resource "kubectl_manifest" "karpenter_crd_provisioners" {
  yaml_body = data.http.karpenter_crd_provisioners.response_body
}

data "http" "karpenter_crd_awsnodetemplates" {
  url = "https://raw.githubusercontent.com/aws/karpenter/v0.16.0/charts/karpenter/crds/karpenter.k8s.aws_awsnodetemplates.yaml"
}

resource "kubectl_manifest" "karpenter_crd_awsnodetemplates" {
  yaml_body = data.http.karpenter_crd_awsnodetemplates.response_body
}

resource "aws_iam_instance_profile" "karpenter" {
  name = "KarpenterNodeInstanceProfile-${var.cluster_name}"
  role = module.eks.worker_iam_role_name
}

resource "aws_iam_policy" "karpenter_controller" {
  name        = "karpenter-controller-policy"
  description = "karpenter iam policy"
  policy      = data.aws_iam_policy_document.karpenter_controller.json
}

module "iam_assumable_role_karpenter" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version                       = "4.7.0"
  create_role                   = true
  role_name                     = "karpenter-controller-${var.cluster_name}"
  provider_url                  = module.eks.cluster_oidc_issuer_url
  oidc_fully_qualified_subjects = ["system:serviceaccount:karpenter:karpenter"]
  role_policy_arns              = [aws_iam_policy.karpenter_controller.arn]
}

resource "aws_iam_service_linked_role" "awsserviceroleforec2spot" {
  aws_service_name = "spot.amazonaws.com"
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws-iam-authenticator"
      args = [
        "token",
        "-i",
        var.cluster_name,
        "-r",
        var.kubeconfig_role
      ]
    }
  }
}

resource "helm_release" "karpenter" {
  # depends_on       = [module.eks.kubeconfig]
  namespace        = "karpenter"
  create_namespace = true

  name       = "karpenter"
  repository = "oci://public.ecr.aws/karpenter"
  chart      = "karpenter"
  version    = "v0.27.5"
  timeout    = 1200

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.iam_assumable_role_karpenter.iam_role_arn
  }

  set {
    name  = "settings.aws.clusterName"
    value = var.cluster_name
  }

  set {
    name  = "settings.aws.clusterEndpoint"
    value = module.eks.cluster_endpoint
  }

  set {
    name  = "settings.aws.defaultInstanceProfile"
    value = aws_iam_instance_profile.karpenter.name
  }

  set {
    name  = "settings.aws.interruptionQueueName"
    value = var.cluster_name
  }

  set {
    name  = "logLevel"
    value = "debug"
  }
}

provider "kubectl" {
  apply_retry_count      = 5
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  load_config_file       = false

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws-iam-authenticator"
    args = [
      "token",
      "-i",
      var.cluster_name,
      "-r",
      var.kubeconfig_role
    ]
  }
}

resource "kubectl_manifest" "karpenter" {
  yaml_body = <<YAML
apiVersion: karpenter.sh/v1alpha5
kind: Provisioner
metadata:
  name: default
spec:
  labels:
    NodeGroup: devopsidiot
  consolidation:
    enabled: ${var.use_spot_karpenter ? "false" : "true"}
  requirements:
    - key: karpenter.sh/capacity-type
      operator: In
      values: ["on-demand"${var.use_spot_karpenter ? ", \"spot\"" : ""}]
    - key: "node.kubernetes.io/instance-type"
      operator: NotIn
      values: ["t2.nano", "t2.micro", "t2.small", "t2.medium", "t2.large", "t2.xlarge", "t2.2xlarge"]
    - key: "node.kubernetes.io/instance-type"
      operator: NotIn
      values: ["t3.nano", "t3.micro", "t3.small", "t3.medium", "t3.large", "t3.xlarge", "t3.2xlarge", "t3a.nano", "t3a.micro", "t3a.small", "t3a.medium", "t3a.large", "t3a.xlarge", "t3a.2xlarge"]
    - key: "node.kubernetes.io/instance-type"
      operator: NotIn
      values: ["t4g.nano", "t4g.micro", "t4g.small", "t4g.medium", "t4g.large", "t4g.xlarge",
      "t4g.2xlarge"]
    - key: "node.kubernetes.io/instance-type"
      operator: NotIn
      values: ["m1.small", "m1.medium"]
    - key: "node.kubernetes.io/instance-type"
      operator: NotIn
      values: ["m3.medium", "m3.large", "m3.xlarge", "m3.2xlarge"]
    - key: "node.kubernetes.io/instance-type"
      operator: NotIn
      values: ["c3.large", "c3.xlarge", "c3.2xlarge", "c3.4xlarge", "c3.8xlarge"]
    - key: "node.kubernetes.io/instance-type"
      operator: NotIn
      values: ["c4.large", "c4.xlarge", "c4.2xlarge", "c4.4xlarge", "c4.8xlarge"]
    - key: "kubernetes.io/arch"
      operator: In
      values: ["amd64"]
  limits:
    resources:
      cpu: 1000
  providerRef:
    name: default
  ${var.use_spot_karpenter ? "" : "#"}ttlSecondsAfterEmpty: 30
  # 1209600 = 60 * 60 * 24 * 14 = two weeks of node being there
  ttlSecondsUntilExpired: 1209600
YAML
}

resource "kubectl_manifest" "karpenterAWSnodeTemplate" {
  yaml_body = <<YAML
apiVersion: karpenter.k8s.aws/v1alpha1
kind: AWSNodeTemplate
metadata:
  name: default
spec:
  instanceProfile: KarpenterNodeInstanceProfile-${var.cluster_name}
  subnetSelector:
    karpenter.sh/discovery: ${var.cluster_name}
  securityGroupSelector:
    Name: ${var.cluster_name}-eks_worker_sg
  blockDeviceMappings:
    - deviceName: /dev/xvda
      ebs:
        volumeSize: 50Gi
        volumeType: gp3
        iops: 3000
        encrypted: true
YAML
}

# resource "kubectl_manifest" "node_group_transition" {
#   yaml_body  = <<YAML
# apiVersion: v1
# kind: ConfigMap
# metadata:
#   name: aws-auth
#   namespace: kube-system
# data:
#   mapRoles: |
#     - rolearn: ${module.eks.worker_iam_role_arn}
#       username: system:node:{{EC2PrivateDNSName}}
#       groups:
#         - system:bootstrappers
#         - system:nodes
# YAML
#   depends_on = [module.eks]
# }
