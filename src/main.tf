locals {
  private_subnet_ids = [for subnet in var.vpc.data.infrastructure.private_subnets : element(split("/", subnet["arn"]), 1)]
  vpc_id             = element(split("/", var.vpc.data.infrastructure.arn), 1)
}

resource "aws_sagemaker_model" "main" {
  name               = "${var.md_metadata.name_prefix}-model"
  execution_role_arn = aws_iam_role.sagemaker_endpoint.arn

  primary_container { 
    image     = var.endpoint_config.primary_container.ecr_image 
    model_data_url = var.endpoint_config.primary_container.model_data
  }
  vpc_config {
    security_group_ids = [aws_security_group.sagemaker_endpoint.id]
    subnets            = local.private_subnet_ids
  } 
}

resource "aws_sagemaker_endpoint_configuration" "main" {
  name = "${var.md_metadata.name_prefix}-endpoint-config"
  # kms_key_arn  = module.kms.key_arn  
  production_variants {
    model_name             = aws_sagemaker_model.main.name
    instance_type          = var.endpoint_config.instance_type
    initial_instance_count = var.endpoint_config.instance_count
  }
}

resource "aws_sagemaker_endpoint" "main" {
  name                 = "${var.md_metadata.name_prefix}-endpoint"
  endpoint_config_name = aws_sagemaker_endpoint_configuration.main.name
}
