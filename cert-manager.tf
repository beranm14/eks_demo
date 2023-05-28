# data "aws_iam_policy_document" "cert_manager" {
#   // TODO review this policy from https://cert-manager.io/docs/configuration/acme/dns01/route53/
#   statement {
#     sid    = "AllowListObjects"
#     effect = "Allow"
#     actions = [
#       "route53:*"
#     ]
#     resources = [
#       "*"
#     ]
#   }
# }

# resource "aws_iam_policy" "cert_manager" {
#   name        = "${local.prefix}-cert-manager"
#   path        = "/"
#   description = "Policy for cert-manager service"
#   policy      = data.aws_iam_policy_document.cert_manager.json
# }

# module "iam_eks_role_cert_manager" {
#   source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
#   role_name = "${local.prefix}-cert-manager"

#   role_policy_arns = {
#     policy = aws_iam_policy.cert_manager.arn
#   }

#   oidc_providers = {
#     eks = {
#       provider_arn               = module.eks.oidc_provider_arn
#       namespace_service_accounts = ["cert-manager:cert-manager"]
#     }
#   }
# }

# output "cert_manager_role_arn" {
#   value = module.iam_eks_role_cert_manager.iam_role_arn
# }
