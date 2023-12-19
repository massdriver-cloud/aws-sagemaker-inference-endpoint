resource "massdriver_artifact" "aws-sagemaker-endpoint" {
  field                = "aws-sagemaker-endpoint"
  provider_resource_id = aws_sagemaker_endpoint.main.arn
  name                 = "AWS SageMaker Endpoint: ${aws_sagemaker_endpoint.main.arn}"
  artifact = jsonencode(
    {
      data = {
        infrastructure = {
          arn           = aws_sagemaker_endpoint.main.arn
          endpoint_name = aws_sagemaker_endpoint.main.name
        }
        security = {
          iam = {
            invoke = {
              policy_arn = aws_iam_policy.invoke_sagemaker_endpoint.arn
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
