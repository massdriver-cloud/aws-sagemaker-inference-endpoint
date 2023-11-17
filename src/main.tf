locals {
  private_subnet_ids = [for subnet in var.vpc.data.infrastructure.private_subnets : element(split("/", subnet["arn"]), 1)]
  vpc_id             = element(split("/", var.vpc.data.infrastructure.arn), 1)
}

resource "aws_sagemaker_model" "main" {
  name               = "${var.md_metadata.name_prefix}-model"
  execution_role_arn = aws_iam_role.sagemaker_endpoint.arn

  primary_container {
    image          = var.endpoint_config.primary_container.ecr_image
    model_data_url = var.endpoint_config.primary_container.model_data
  }
  vpc_config {
    security_group_ids = [aws_security_group.sagemaker_endpoint.id]
    subnets            = local.private_subnet_ids
  }
  depends_on = [
    aws_iam_role.sagemaker_endpoint,
    aws_security_group.sagemaker_endpoint
  ]
}

resource "aws_sagemaker_endpoint_configuration" "main" {
  name = "${var.md_metadata.name_prefix}-endpoint-config"
  production_variants {
    model_name             = aws_sagemaker_model.main.name
    instance_type          = var.endpoint_config.instance_type
    initial_instance_count = var.endpoint_config.instance_count
  }
}

resource "aws_sagemaker_endpoint" "main" {
  name                 = "${var.md_metadata.name_prefix}-endpoint"
  endpoint_config_name = aws_sagemaker_endpoint_configuration.main.name
  # Workaround to prevent orphaned ENIs from being created by SageMaker. https://github.com/hashicorp/terraform-provider-aws/issues/34397
  provisioner "local-exec" {
    command = <<EOT
      set -e
      TEMP_ROLE=$(aws sts assume-role --role-arn "${var.aws_authentication.data.arn}" --role-session-name "TerraformENIModify" --external-id "${var.aws_authentication.data.external_id}" --query 'Credentials.[AccessKeyId,SecretAccessKey,SessionToken]' --output text)
      AWS_ACCESS_KEY_ID=$(echo $TEMP_ROLE | cut -f1 -d' ')
      AWS_SECRET_ACCESS_KEY=$(echo $TEMP_ROLE | cut -f2 -d' ')
      AWS_SESSION_TOKEN=$(echo $TEMP_ROLE | cut -f3 -d' ')
      export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
      export AWS_DEFAULT_REGION="${var.vpc.specs.aws.region}"
      
      ENI_ID=$(aws ec2 describe-network-interfaces --region $AWS_DEFAULT_REGION --filters "Name=group-id,Values=${aws_security_group.sagemaker_endpoint.id}" --query 'NetworkInterfaces[0].NetworkInterfaceId' --output text)
      ATTACHMENT_ID=$(aws ec2 describe-network-interfaces --region $AWS_DEFAULT_REGION --filters "Name=group-id,Values=${aws_security_group.sagemaker_endpoint.id}" --query 'NetworkInterfaces[0].Attachment.AttachmentId' --output text)

      aws ec2 modify-network-interface-attribute --region $AWS_DEFAULT_REGION --network-interface-id $ENI_ID --attachment AttachmentId=$ATTACHMENT_ID,DeleteOnTermination=true
    EOT
  }
}
