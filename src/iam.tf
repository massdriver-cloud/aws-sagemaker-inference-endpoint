resource "aws_iam_role" "sagemaker_endpoint" {
  name               = "${var.md_metadata.name_prefix}-endpoint"
  assume_role_policy = data.aws_iam_policy_document.sagemaker_assume_role.json
}

data "aws_iam_policy_document" "sagemaker_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "sagemaker_endpoint" {
  statement {
    sid       = "PassRole"
    effect    = "Allow"
    actions   = ["iam:PassRole"]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "iam:PassedToService"
      values   = ["sagemaker.amazonaws.com"]
    }
  }
  statement {
    sid    = "S3ReadAccess"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]
    resources = [
      "arn:aws:s3:::jumpstart-cache-prod-${var.region}",
       "arn:aws:s3:::jumpstart-cache-prod-${var.region}/*"
    ]
  }
  statement {
    sid       = "ECRAccess"
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "ecr:ListTagsForResource",
      "ecr:ListImages",
      "ecr:DescribeRepositories",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetLifecyclePolicy",
      "ecr:DescribeImageScanFindings",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:GetAuthorizationToken",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:DescribeImages",
      "ecr:GetRepositoryPolicy"
    ]
  }
  statement {
    sid       = "EC2Access"
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:CreateNetworkInterfacePermission",
      "ec2:DescribeVpcs",
      "ec2:DeleteNetworkInterface",
      "ecr:GetAuthorizationToken",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeDhcpOptions"
    ]
  }
  statement {
    sid    = "SageMakerAccess"
    effect = "Allow"
    actions = [
      "sagemaker:InvokeEndpoint",
      "sagemaker:InvokeEndpointAsync",
      "sagemaker:CreateEndpoint",
      "sagemaker:DeleteEndpoint"
    ]
    resources = ["arn:aws:sagemaker:${var.region}:${data.aws_caller_identity.current.account_id}:endpoint/*"]
  }
}

resource "aws_iam_policy" "sagemaker_endpoint" {
  name   = "${var.md_metadata.name_prefix}-policy"
  policy = data.aws_iam_policy_document.sagemaker_endpoint.json
}

resource "aws_iam_role_policy_attachment" "sagemaker_endpoint" {
  role       = aws_iam_role.sagemaker_endpoint.name
  policy_arn = aws_iam_policy.sagemaker_endpoint.arn
}

resource "aws_iam_role_policy_attachment" "attach_s3_read_policy" {
  role       = aws_iam_role.sagemaker_endpoint.name
  policy_arn = var.s3_model_bucket.data.security.iam.read.policy_arn
}

resource "aws_iam_role_policy_attachment" "attach_s3_write_policy" {
  role       = aws_iam_role.sagemaker_endpoint.name
  policy_arn = var.s3_model_bucket.data.security.iam.write.policy_arn
}