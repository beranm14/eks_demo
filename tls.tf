# module "acm" {
#   source  = "terraform-aws-modules/acm/aws"
#   version = "~> 4.0"

#   domain_name  = "trustsoft.beranm.cz"
#   zone_id      = aws_route53_zone.primary.zone_id

#   subject_alternative_names = [
#     "*.trustsoft.beranm.cz",
#   ]

#   wait_for_validation = true
# }