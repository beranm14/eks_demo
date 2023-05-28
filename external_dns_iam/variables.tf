variable "service_account_name" {
  description = "The name of the service account to create"
  type        = string
  default     = "external-dns"
}

variable "policy_allowed_zone_ids" {
  description = "List of Route53 zone IDs to allow external-dns to manage"
  type        = list(string)
  default     = []
}

variable "namespace" {
  default = "default"
}

variable "irsa_assume_role_arn" {
  default     = ""
  description = "Assume role arn. Assume role must be enabled."
}

variable "cluster_identity_oidc_issuer" {
  type        = string
  description = "The OIDC Identity issuer for the cluster"
}

variable "cluster_identity_oidc_issuer_arn" {
  type        = string
  description = "The OIDC Identity issuer ARN for the cluster that can be used to associate IAM roles with a service account"
}