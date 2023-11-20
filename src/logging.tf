
locals {
  log_group_name = "/aws/sagemaker/Endpoints/${var.md_metadata.name_prefix}-endpoint"
}

resource "aws_cloudwatch_log_group" "endpoint_log_group" {
  name              = local.log_group_name
  retention_in_days = try(var.monitoring.endpoint_log_retention, 7)
}
