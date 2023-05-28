# resource "random_string" "chart_museum_bucket_suffix" {
#   length  = 8
#   special = false
#     upper   = false
# }

# resource "aws_s3_bucket" "chart_museum_bucket" {
#   bucket        = "${local.prefix}-chart-museum-${random_string.chart_museum_bucket_suffix.result}"
#   force_destroy = true
# }

# data "aws_iam_policy_document" "chart_museum" {
#   statement {
#     sid    = "AllowListObjects"
#     effect = "Allow"
#     actions = [
#       "s3:ListBucket"
#     ]
#     resources = [
#       aws_s3_bucket.chart_museum_bucket.arn
#     ]
#   }
#   statement {
#     sid    = "AllowEditObjects"
#     effect = "Allow"
#     actions = [
#       "s3:DeleteObject",
#       "s3:GetObject",
#       "s3:PutObject",
#     ]
#     resources = [
#       "${aws_s3_bucket.chart_museum_bucket.arn}/*"
#     ]
#   }
# }

# resource "aws_iam_policy" "helm" {
#   name        = "${local.prefix}-chart-museum"
#   path        = "/"
#   description = "Policy for chart-museum service"
#   policy      = data.aws_iam_policy_document.chart_museum.json
# }

# module "iam_eks_role" {
#   source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
#   role_name = "${local.prefix}-chart-museum"

#   role_policy_arns = {
#     policy = aws_iam_policy.helm.arn
#   }

#   oidc_providers = {
#     eks = {
#       provider_arn               = module.eks.oidc_provider_arn
#       namespace_service_accounts = ["chartmuseum:chartmuseum"]
#     }
#   }
# }

# output "chart_museum_role_arn" {
#     value = module.iam_eks_role.iam_role_arn
# }
# output "chart_bucket_name" {
#     value = aws_s3_bucket.chart_museum_bucket.bucket
# }

# output "chart_bucket_region" {
#     value = aws_s3_bucket.chart_museum_bucket.region
# }
