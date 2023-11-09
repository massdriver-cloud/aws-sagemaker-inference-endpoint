resource "massdriver_artifact" "endpoint" {
  field                = "endpoint"
  provider_resource_id = aws_sagemaker_endpoint.main.arn
  name                 = "AWS Sagemaker Endpoint: ${aws_sagemaker_endpoint.main.arn}"
  artifact = jsonencode(
    {
        data = {
            infrastructure = {
                endpoint_arn = aws_sagemaker_endpoint.main.arn
                model_arn    = aws_sagemaker_model.main.arn
            }
            security = {
                iam = {
                    execution = {
                        policy_arn = aws_iam_policy.sagemaker_endpoint.arn
                    }
                }
            }
        }
        specs = {
            aws = {
              region = var.vpc.specs.aws.region
            }
        }
    }
  )
}