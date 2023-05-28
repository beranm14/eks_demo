# data "aws_region" "current" {}

# data "aws_eks_cluster" "target" {
#   name = local.name
# }

# data "aws_eks_cluster_auth" "aws_iam_authenticator" {
#   name = data.aws_eks_cluster.target.name
# }

# provider "helm" {
#   kubernetes {
#     host                   = module.eks.cluster_endpoint
#     cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

#     exec {
#       api_version = "client.authentication.k8s.io/v1beta1"
#       command     = "aws"
#       # This requires the awscli to be installed locally where Terraform is executed
#       args = ["eks", "get-token", "--profile", "trustsoft", "--cluster-name", module.eks.cluster_name]
#     }
#   }
# }

# module "lb_controller_argo_helm" {
#   source = "git@github.com:lablabs/terraform-aws-eks-load-balancer-controller.git"

#   enabled = true

#   cluster_name                     = local.name
#   cluster_identity_oidc_issuer     = module.eks.oidc_provider
#   cluster_identity_oidc_issuer_arn = module.eks.oidc_provider_arn

#   helm_release_name = "aws-lbc-argo-helm"
#   namespace         = "aws-lb-controller-argo-helm"

#   argo_namespace = "argocd"
#   argo_sync_policy = {
#     "automated" : {}
#     "syncOptions" = ["CreateNamespace=true"]
#   }
# }
