resource "aws_iam_policy" "AWSLoadBalancerControllerIAMPolicy" {
  name        = "${var.environment}-AWSLoadBalancerControllerIAMPolicy"
  path        = "/"
  description = "Policy to allow ALB ingress controller access to load balancers."
  policy      = data.aws_iam_policy_document.AWSLoadBalancerControllerIAMPolicy.json
}

resource "aws_iam_policy" "EKSExternalDNSPolicy" {
  name        = "${var.environment}-EKSExternalDNSPolicy"
  path        = "/"
  description = "Policy to allow updates to the DNS hosted zone."
  policy      = data.aws_iam_policy_document.EKSExternalDNS.json
}

resource "aws_iam_policy" "EKSExternalSecretsPolicy" {
  name        = "${var.environment}-EKSExternalSecretsPolicy"
  path        = "/"
  description = "Policy to allow EKS to pull in select secrets."
  policy      = data.aws_iam_policy_document.EKSExternalSecrets.json
}

resource "aws_iam_policy" "ClusterAutoscalerIAMPolicy" {
  name        = "${var.environment}-ClusterAutoscalerIAMPolicy"
  path        = "/"
  description = "Policy to allow EKS to autoscale nodes based on metrics."
  policy      = data.aws_iam_policy_document.ClusterAutoscalerIAMPolicy.json
}

data "aws_kms_alias" "kms_alias" {
  name = var.kms_alias
}
data "aws_iam_policy_document" "EKSExternalSecrets" {
  statement {
    sid       = "1"
    actions   = ["ssm:*"]
    resources = values(var.secrets)
  }
  statement {
    actions   = ["kms:Decrypt"]
    resources = [data.aws_kms_alias.kms_alias.target_key_arn]
  }
}

data "aws_iam_policy_document" "EKSExternalDNS" {
  statement {
    actions   = ["route53:ChangeResourceRecordSets"]
    resources = ["arn:aws:route53:::hostedzone/*"]
  }
  statement {
    actions   = ["route53:ListHostedZones", "route53:ListResourceRecordSets"]
    resources = ["*"]
  }
}
data "aws_iam_policy_document" "AWSLoadBalancerControllerIAMPolicy" {
  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]
    actions   = ["iam:CreateServiceLinkedRole"]

    condition {
      test     = "StringEquals"
      variable = "iam:AWSServiceName"
      values   = ["elasticloadbalancing.amazonaws.com"]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeAddresses",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeVpcs",
      "ec2:DescribeVpcPeeringConnections",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeInstances",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeTags",
      "ec2:GetCoipPoolUsage",
      "ec2:DescribeCoipPools",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticloadbalancing:DescribeLoadBalancerAttributes",
      "elasticloadbalancing:DescribeListeners",
      "elasticloadbalancing:DescribeListenerCertificates",
      "elasticloadbalancing:DescribeSSLPolicies",
      "elasticloadbalancing:DescribeRules",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeTargetGroupAttributes",
      "elasticloadbalancing:DescribeTargetHealth",
      "elasticloadbalancing:DescribeTags",
    ]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "cognito-idp:DescribeUserPoolClient",
      "acm:ListCertificates",
      "acm:DescribeCertificate",
      "iam:ListServerCertificates",
      "iam:GetServerCertificate",
      "waf-regional:GetWebACL",
      "waf-regional:GetWebACLForResource",
      "waf-regional:AssociateWebACL",
      "waf-regional:DisassociateWebACL",
      "wafv2:GetWebACL",
      "wafv2:GetWebACLForResource",
      "wafv2:AssociateWebACL",
      "wafv2:DisassociateWebACL",
      "shield:GetSubscriptionState",
      "shield:DescribeProtection",
      "shield:CreateProtection",
      "shield:DeleteProtection",
    ]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupIngress",
    ]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]
    actions   = ["ec2:CreateSecurityGroup"]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:ec2:*:*:security-group/*"]
    actions   = ["ec2:CreateTags"]

    condition {
      test     = "StringEquals"
      variable = "ec2:CreateAction"
      values   = ["CreateSecurityGroup"]
    }

    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values   = ["false"]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:ec2:*:*:security-group/*"]

    actions = [
      "ec2:CreateTags",
      "ec2:DeleteTags",
    ]

    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values   = ["true"]
    }

    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values   = ["false"]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:DeleteSecurityGroup",
    ]

    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values   = ["false"]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "elasticloadbalancing:CreateLoadBalancer",
      "elasticloadbalancing:CreateTargetGroup",
    ]

    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values   = ["false"]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "elasticloadbalancing:CreateListener",
      "elasticloadbalancing:DeleteListener",
      "elasticloadbalancing:CreateRule",
      "elasticloadbalancing:DeleteRule",
    ]
  }

  statement {
    sid    = ""
    effect = "Allow"

    resources = [
      "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*",
      "arn:aws:elasticloadbalancing:*:*:loadbalancer/net/*/*",
      "arn:aws:elasticloadbalancing:*:*:loadbalancer/app/*/*",
    ]

    actions = [
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:RemoveTags",
    ]

    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values   = ["true"]
    }

    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values   = ["false"]
    }
  }

  statement {
    sid    = ""
    effect = "Allow"

    resources = [
      "arn:aws:elasticloadbalancing:*:*:listener/net/*/*/*",
      "arn:aws:elasticloadbalancing:*:*:listener/app/*/*/*",
      "arn:aws:elasticloadbalancing:*:*:listener-rule/net/*/*/*",
      "arn:aws:elasticloadbalancing:*:*:listener-rule/app/*/*/*",
    ]

    actions = [
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:RemoveTags",
    ]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "elasticloadbalancing:ModifyLoadBalancerAttributes",
      "elasticloadbalancing:SetIpAddressType",
      "elasticloadbalancing:SetSecurityGroups",
      "elasticloadbalancing:SetSubnets",
      "elasticloadbalancing:DeleteLoadBalancer",
      "elasticloadbalancing:ModifyTargetGroup",
      "elasticloadbalancing:ModifyTargetGroupAttributes",
      "elasticloadbalancing:DeleteTargetGroup",
    ]

    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values   = ["false"]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:elasticloadbalancing:*:*:targetgroup/*/*"]

    actions = [
      "elasticloadbalancing:RegisterTargets",
      "elasticloadbalancing:DeregisterTargets",
    ]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "elasticloadbalancing:SetWebAcl",
      "elasticloadbalancing:ModifyListener",
      "elasticloadbalancing:AddListenerCertificates",
      "elasticloadbalancing:RemoveListenerCertificates",
      "elasticloadbalancing:ModifyRule",
    ]
  }
}
data "aws_iam_policy_document" "ClusterAutoscalerIAMPolicy" {
  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
      "autoscaling:DescribeTags",
    ]
  }
}

# I am open to moving this part around - I'm just experimenting with converging all the SOPS stuff into a single place
# Well, at least the sops iam stuff
data "aws_iam_policy_document" "sops_policy" {
  statement {
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }
  statement {
    actions   = ["kms:Decrypt"]
    resources = ["*"]
  }
}

data "aws_iam_policy" "ec2_registry_ro" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_policy" "sops_policy" {
  name = "sops-policy"
  description = "Policy for sops decryption within EKS cluster"
  policy = data.aws_iam_policy_document.sops_policy.json
}

module "sops_iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "4.7.0"
  role_name  = "sops-oidc-role"
  create_role = true
  provider_urls = [module.eks.cluster_oidc_issuer_url]
  oidc_fully_qualified_subjects = ["system:serviceaccount:flux-system:kustomize-controller"]
  role_policy_arns = concat([aws_iam_policy.sops_policy.arn, data.aws_iam_policy.ec2_registry_ro.arn])
  number_of_role_policy_arns = 2

  depends_on = [
    module.eks
  ]
}