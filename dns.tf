# resource "aws_route53_zone" "primary" {
#   name          = "trustsoft.beranm.cz"
#   force_destroy = true
# }

# output "name_servers" {
#   value = aws_route53_zone.primary.name_servers
# }

# data "aws_iam_policy_document" "external_dns" {
#   statement {
#     sid    = "AllowEditObjects"
#     effect = "Allow"
#     actions = [
#       "route53:*",
#     ]
#     resources = [
#       "*",
#     ]
#   }
# }

# resource "aws_iam_policy" "helm" {
#   name        = "${local.prefix}-external-dns"
#   path        = "/"
#   description = "Policy for external-dns service"
#   policy      = data.aws_iam_policy_document.external_dns.json
# }

# module "external_dns" {
#   source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
#   role_name = "${local.prefix}-external-dns"

#   role_policy_arns = {
#     policy = aws_iam_policy.helm.arn
#   }

#   oidc_providers = {
#     eks = {
#       provider_arn               = module.eks.oidc_provider_arn
#       namespace_service_accounts = ["default:external-dns"]
#     }
#   }
# }

# output "external_dns_role_arn" {
#   value = module.external_dns.iam_role_arn
# }
