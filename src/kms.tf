module "kms" {
  source      = "github.com/massdriver-cloud/terraform-modules//aws/aws-kms-key?ref=9d722be"
  md_metadata = var.md_metadata
  policy      = data.aws_iam_policy_document.kms_key.json
}

data "aws_iam_policy_document" "kms_key" {
  statement {
    sid    = "Allow access for all principals in the account that are authorized"
    effect = "Allow"
    actions = [
      "kms:Create*",
      "kms:Decrypt*",
      "kms:Describe*",
      "kms:Encrypt*",
      "kms:Generate*",
      "kms:List*",
      "kms:ReEncrypt*",
    ]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:${data.aws_partition.current.id}:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }

    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values   = ["eks.${var.vpc.specs.aws.region}.amazonaws.com"]
    }
  }

  statement {
    sid    = "Allow administration of the key"
    effect = "Allow"
    actions = [
      "kms:*"
    ]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:${data.aws_partition.current.id}:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }
  }

  statement {
    sid    = "Allow use of the key"
    effect = "Allow"
    actions = [
      "kms:Create*",
      "kms:Decrypt*",
      "kms:Describe*",
      "kms:Encrypt*",
      "kms:Generate*",
      "kms:List*",
      "kms:ReEncrypt*",
    ]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = [
        aws_iam_role.sagemaker_endpoint.arn
      ]
    }
  }

  # Permission to allow AWS services that are integrated with AWS KMS to use the CMK,
  # particularly services that use grants.
  statement {
    sid    = "Allow attachment of persistent resources"
    effect = "Allow"
    actions = [
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:RevokeGrant",
    ]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = [
        aws_iam_role.sagemaker_endpoint.arn
      ]
    }

    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values   = ["true"]
    }
  }

  // https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/encrypt-log-data-kms.html
  statement {
    sid    = "Allow access for cloudwatch logs"
    effect = "Allow"
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]
    resources = ["*"]

    principals {
      type        = "Service"
      identifiers = ["logs.${var.vpc.specs.aws.region}.amazonaws.com"]
    }
  }
}
