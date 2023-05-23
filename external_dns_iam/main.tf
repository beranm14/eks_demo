locals {
  name = var.service_account_name
}

data "aws_iam_policy_document" "this" {
  statement {
    sid    = "ChangeResourceRecordSets"
    effect = "Allow"
    actions = [
      "route53:ChangeResourceRecordSets",
    ]
    resources = formatlist(
      "arn:aws:route53:::hostedzone/%s",
      var.policy_allowed_zone_ids
    )
  }

  statement {
    sid    = "ListResourceRecordSets"
    effect = "Allow"
    actions = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
      "route53:ListTagsForResource",
    ]
    resources = [
      "*",
    ]
  }
}

data "aws_iam_policy_document" "this_assume" {
  statement {
    sid    = "AllowAssumeExternalDNSRole"
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
      "sts:AssumeRoleWithWebIdentity",
    ]
    resources = [
      var.irsa_assume_role_arn,
    ]
  }

    statement {
    sid    = "ChangeResourceRecordSets"
    effect = "Allow"
    actions = [
      "route53:ChangeResourceRecordSets",
    ]
    resources = formatlist(
      "arn:aws:route53:::hostedzone/%s",
      var.policy_allowed_zone_ids
    )
  }

  statement {
    sid    = "ListResourceRecordSets"
    effect = "Allow"
    actions = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
      "route53:ListTagsForResource",
    ]
    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "this" {
  name        = local.name
  path        = "/"
  description = "Policy for external-dns service"
  policy      = data.aws_iam_policy_document.this_assume.json
}

data "aws_iam_policy_document" "this_irsa" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]
    principals {
      type        = "Federated"
      identifiers = [var.cluster_identity_oidc_issuer_arn]
    }
    condition {
      test     = "StringEquals"
      variable = "${replace(var.cluster_identity_oidc_issuer, "https://", "")}:sub"

      values = [
        "system:serviceaccount:${var.namespace}:${var.service_account_name}",
      ]
    }
  }
}

resource "aws_iam_role" "this" {
  name               = local.name
  assume_role_policy = data.aws_iam_policy_document.this_irsa.json
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
