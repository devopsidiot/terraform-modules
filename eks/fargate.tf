# Create an EKS Fargate Profile
# note: maximum of 5 selectores per profile

#  Uncomment to create an EKS Fargate Profile ()
# resource "aws_eks_fargate_profile" "default-fargateprofile" {
#   cluster_name           = var.cluster_name
#   pod_execution_role_arn = aws_iam_role.fargate_execution_role.arn
#   subnet_ids             = var.private_subnets
#   fargate_profile_name   = var.fargateprofile_name

#   dynamic "selector" {
#     for_each = var.fargate_namespaces

#     content {
#       namespace = selector.value
#     }
#   }

#   depends_on = [
#     module.eks
#   ]
# }
