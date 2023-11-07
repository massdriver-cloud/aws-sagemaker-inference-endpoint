resource "aws_sagemaker_endpoint_configuration" "main" {
  name = "${var.md_metadata.name_prefix}-endpoint-config"

  production_variants {
    model_name             = var.endpoint_config.model_name
    instance_type          = var.endpoint_config.instance_type
    initial_instance_count = var.endpoint_config.instance_count
  }
}

resource "aws_sagemaker_endpoint" "main" {
  name                 = "${var.md_metadata.name_prefix}-endpoint"
  endpoint_config_name = aws_sagemaker_endpoint_configuration.main.name
} 