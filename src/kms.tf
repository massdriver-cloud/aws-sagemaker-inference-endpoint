// Policy from https://docs.aws.amazon.com/efs/latest/ug/encryption-at-rest.html
data "aws_iam_policy_document" "efs" {
  statement {
    sid = "Allow access to EFS for all principals in the account that are authorized to use EFS"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:CreateGrant",
      "kms:DescribeKey"
    ]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "kms:ViaService"
      values   = ["elasticfilesystem.*.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }

  statement {
    sid = "Allow administration of the key"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]
  }
}

module "kms" {
  source      = "github.com/massdriver-cloud/terraform-modules//aws/aws-kms-key?ref=afe781a"
  md_metadata = var.md_metadata
  policy      = data.aws_iam_policy_document.efs.json
}
