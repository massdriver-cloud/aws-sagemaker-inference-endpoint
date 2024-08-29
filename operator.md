## AWS SageMaker Inference Endpoint

AWS SageMaker is a fully managed service that enables developers and data scientists to quickly build, train, and deploy machine learning models at any scale. An inference endpoint in SageMaker allows you to deploy trained models for real-time predictions.

### Design Decisions

1. **IAM Roles & Policies**: 
    - A dedicated IAM role is created for the SageMaker endpoint, with policies that allow it to assume roles, access CloudWatch logs, interact with S3, ECR, EC2, and perform SageMaker-specific actions.
    - Separate policies are created to invoke the SageMaker endpoint.

2. **KMS Encryption**: 
    - CloudWatch logs related to the SageMaker endpoint are encrypted using a KMS key to ensure data privacy and compliance.

3. **VPC Configuration**:
    - The endpoint is configured to use private subnets, enhancing network security by isolating the endpoint from public access.

4. **Security Groups**:
    - A security group specifically for SageMaker is configured to allow all outbound traffic, ensuring the endpoint can communicate with AWS services as required.

5. **Provisioning**:
    - Local-exec provisioner is used to modify network interface attributes to ensure that ENIs (Elastic Network Interfaces) created by SageMaker are deleted upon termination of the endpoint to prevent orphaned ENIs from being left behind.

### Runbook

#### Endpoint Not Responding

If your SageMaker endpoint is not responding, the following commands can help diagnose the issue.

Check the endpoint status:

```sh
aws sagemaker describe-endpoint --endpoint-name <your-endpoint-name>
```
Make sure that the `EndpointStatus` is `InService`. If the status is `Failed`, check the `FailureReason` in the output of the command.

#### Network Interface Issues

SageMaker endpoints create network interfaces in your VPC. Ensure these interfaces are correctly configured.

List network interfaces related to your SageMaker endpoint:

```sh
aws ec2 describe-network-interfaces --filters "Name=group-id,Values=<your-security-group-id>"
```
Check the attachment status and ensure that the network interfaces are attached correctly.

#### CloudWatch Log Analysis

Logs can be immensely helpful in diagnosing issues with your SageMaker endpoint. View logs in CloudWatch using the following steps:

1. Open the CloudWatch console.
2. Navigate to **Log Groups**.
3. Find and select the log group associated with your SageMaker endpoint (e.g., `/aws/sagemaker/Endpoints/<your-endpoint-name>`).
4. Review the logs for any error messages or failed invocations.

#### Model Issues

If there are issues specific to the model deployed:

1. Ensure the image URI and model data URL specified in the SageMaker model are correct.
2. Check the environment variables passed to the model for any misconfigurations.

Verify model configuration:

```sh
aws sagemaker describe-model --model-name <your-model-name>
```

#### IAM Role Verification

Ensure the SageMaker execution role has the correct permissions:

1. List the policies attached to the SageMaker execution role:

```sh
aws iam list-attached-role-policies --role-name <your-execution-role-name>
```

2. Review and ensure all required policies are attached.

#### S3 Bucket Access Issues

If your model relies on S3 for input data, ensure the SageMaker execution role has the necessary permissions to access the S3 bucket:

Check the bucket policies:

```sh
aws s3api get-bucket-policy --bucket <your-bucket-name>
```

Ensure the IAM role appears in the bucket access policies and has sufficient permissions (`s3:GetObject`, `s3:ListBucket`).

