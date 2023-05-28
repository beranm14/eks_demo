resource "aws_route53_zone" "primary" {
  name = "trustsoft.beranm.cz"
}

output "name_servers" {
  value = aws_route53_zone.primary.name_servers
}

module "external_dns" {
    source = "./external_dns_iam"

    service_account_name = "${local.prefix}-external-dns"
    policy_allowed_zone_ids = [aws_route53_zone.primary.zone_id]
    irsa_assume_role_arn = module.eks.cluster_iam_role_arn
    cluster_identity_oidc_issuer = module.eks.oidc_provider
    cluster_identity_oidc_issuer_arn = module.eks.oidc_provider_arn
}

output "external_dns_role" {
  value = module.external_dns.role
}
