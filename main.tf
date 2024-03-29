data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {}

locals {
  prefix          = "beranm"
  name            = "${local.prefix}-testing-01"
  cluster_version = "1.28"
  region          = "eu-west-1"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
  }
}

# module "ebs_csi_irsa_role" {
#   source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

#   role_name             = "${local.name}-ebs-csi"
#   attach_ebs_csi_policy = true

#   oidc_providers = {
#     ex = {
#       provider_arn               = module.eks.oidc_provider_arn
#       namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
#     }
#   }
# }

# module "efs_csi_irsa_role" {
#   source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

#   role_name             = "${local.name}-efs-csi"
#   attach_efs_csi_policy = true

#   oidc_providers = {
#     ex = {
#       provider_arn               = module.eks.oidc_provider_arn
#       namespace_service_accounts = ["kube-system:efs-csi-controller-sa"]
#     }
#   }
# }

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.20.0"

  cluster_name                   = local.name
  cluster_version                = local.cluster_version
  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }

    # https://docs.aws.amazon.com/eks/latest/userguide/managing-ebs-csi.html#csi-iam-role
    # aws-ebs-csi-driver = {
    #   service_account_role_arn = module.ebs_csi_irsa_role.iam_role_arn
    #   most_recent              = true
    # }
    # aws-efs-csi-driver = {
    #   service_account_role_arn = module.efs_csi_irsa_role.iam_role_arn
    #   most_recent              = true
    # }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent              = true
      before_compute           = true
      service_account_role_arn = module.vpc_cni_irsa.iam_role_arn
      configuration_values = jsonencode({
        env = {
          # Reference docs https://docs.aws.amazon.com/eks/latest/userguide/cni-increase-ip-addresses.html
          ENABLE_PREFIX_DELEGATION = "true"
          WARM_PREFIX_TARGET       = "1"
        }
      })
    }
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    instance_types = ["t3.medium"]
    capacity_type  = "SPOT"

    iam_role_attach_cni_policy = true

    # vpc_security_group_ids = [aws_security_group.efs.id]
  }

  eks_managed_node_groups = {
    default_node_group = {
      use_custom_launch_template = false
      disk_size                  = 50
      desired_size               = 2
      min_size                   = 2
      subnet_ids                 = [module.vpc.private_subnets[0]]
    }
  }

  tags = local.tags
}
