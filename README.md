[![Massdriver][logo]][website]

# aws-sagemaker-inference-endpoint

[![Release][release_shield]][release_url]
[![Contributors][contributors_shield]][contributors_url]
[![Forks][forks_shield]][forks_url]
[![Stargazers][stars_shield]][stars_url]
[![Issues][issues_shield]][issues_url]
[![MIT License][license_shield]][license_url]

AWS SageMaker Inference Endpoint for hosting an AI model existing in your AWS SageMaker Model Registry

---

## Design

For detailed information, check out our [Operator Guide](operator.mdx) for this bundle.

## Usage

Our bundles aren't intended to be used locally, outside of testing. Instead, our bundles are designed to be configured, connected, deployed and monitored in the [Massdriver][website] platform.

### What are Bundles?

Bundles are the basic building blocks of infrastructure, applications, and architectures in [Massdriver][website]. Read more [here](https://docs.massdriver.cloud/concepts/bundles).

## Bundle

<!-- COMPLIANCE:START -->

Security and compliance scanning of our bundles is performed using [Bridgecrew](https://www.bridgecrew.cloud/). Massdriver also offers security and compliance scanning of operational infrastructure configured and deployed using the platform.

| Benchmark                                                                                                                                                                                                                                                       | Description                        |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------- |
| [![Infrastructure Security](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-sagemaker-inference-endpoint/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=&benchmark=INFRASTRUCTURE+SECURITY) | Infrastructure Security Compliance |
| [![PCI-DSS](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-sagemaker-inference-endpoint/pci>)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=&benchmark=PCI-DSS+V3.2) | Payment Card Industry Data Security Standards Compliance |
| [![NIST-800-53](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-sagemaker-inference-endpoint/nist>)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=&benchmark=NIST-800-53) | National Institute of Standards and Technology Compliance |
| [![ISO27001](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-sagemaker-inference-endpoint/iso>)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=&benchmark=ISO27001) | Information Security Management System, ISO/IEC 27001 Compliance |
| [![SOC2](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-sagemaker-inference-endpoint/soc2>)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=&benchmark=SOC2)| Service Organization Control 2 Compliance |
| [![HIPAA](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-sagemaker-inference-endpoint/hipaa>)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=&benchmark=HIPAA) | Health Insurance Portability and Accountability Compliance |

<!-- COMPLIANCE:END -->

### Params

Form input parameters for configuring a bundle for deployment.

<details>
<summary>View</summary>

<!-- PARAMS:START -->
## Properties

- **`endpoint_config`** *(object)*
  - **`instance_count`** *(integer)*: Initial number of instances used for auto-scaling. Minimum: `1`.
  - **`instance_type`** *(string)*: Instance type to use for the SageMaker endpoint.
    - **One of**
      - ml.t3.medium - Comparable to Basic CPUs
      - ml.t3.large - Comparable to Basic CPUs with more Memory
      - ml.m5.large - General Purpose (2 vCPU, 8 GiB Memory)
      - ml.m5.xlarge - General Purpose (4 vCPU, 16 GiB Memory)
      - ml.c5.2xlarge - High CPU (8 vCPU, 16 GiB Memory)
      - ml.c5.4xlarge - High CPU (16 vCPU, 32 GiB Memory)
      - ml.p2.xlarge - GPU Compute (1 K80 GPU)
      - ml.p2.8xlarge - High-Performance GPUs (8 K80 GPUs)
      - ml.p3.2xlarge - Advanced GPU Compute (1 V100 GPU)
      - ml.p3.8xlarge - High-Performance GPUs (4 V100 GPUs)
      - ml.g4dn.xlarge - GPU Optimized (1 T4 GPU)
      - ml.g4dn.12xlarge - GPU Optimized for Graphics (4 T4 GPUs)
      - ml.inf1.xlarge - Inferentia Chips for High Performance Inference
      - ml.inf1.6xlarge - High Performance Inferentia Chips
      - ml.c5.9xlarge - Very High CPU (36 vCPU, 72 GiB Memory)
      - ml.g5.large - NVIDIA A10G GPU Optimized (1 vCPU, 8 GiB Memory)
      - ml.g5.xlarge - NVIDIA A10G GPU Optimized (4 vCPU, 16 GiB Memory)
      - ml.g5.2xlarge - NVIDIA A10G GPU Optimized (8 vCPU, 32 GiB Memory)
      - ml.g5.4xlarge - NVIDIA A10G GPU Optimized (16 vCPU, 64 GiB Memory)
      - ml.g5.8xlarge - NVIDIA A10G GPU Optimized (32 vCPU, 128 GiB Memory)
      - ml.g5.12xlarge - High Performance NVIDIA A10G GPUs (48 vCPU, 192 GiB Memory)
      - ml.g5.16xlarge - High Performance NVIDIA A10G GPUs (64 vCPU, 256 GiB Memory)
      - ml.g5.24xlarge - High Performance NVIDIA A10G GPUs (96 vCPU, 384 GiB Memory)
  - **`primary_container`** *(object)*
    - **`ecr_image`** *(string)*: The ECR Image URI. (e.g. 	763104351884.dkr.ecr.us-east-1.amazonaws.com/pytorch-inference:2.1.0-gpu-py310-cu118-ubuntu20.04-ec2).
    - **`model_data`** *(string)*: The S3 URI of the model data. (e.g. s3://bucket-name/model.tar.gz).
<!-- PARAMS:END -->

</details>

### Connections

Connections from other bundles that this bundle depends on.

<details>
<summary>View</summary>

<!-- CONNECTIONS:START -->
## Properties

- **`aws_authentication`** *(object)*: . Cannot contain additional properties.
  - **`data`** *(object)*
    - **`arn`** *(string)*: Amazon Resource Name.

      Examples:
      ```json
      "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
      ```

      ```json
      "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
      ```

    - **`external_id`** *(string)*: An external ID is a piece of data that can be passed to the AssumeRole API of the Security Token Service (STS). You can then use the external ID in the condition element in a role's trust policy, allowing the role to be assumed only when a certain value is present in the external ID.
  - **`specs`** *(object)*
    - **`aws`** *(object)*: .
      - **`region`** *(string)*: AWS Region to provision in.

        Examples:
        ```json
        "us-west-2"
        ```

- **`s3_model_bucket`** *(object)*: Cannot contain additional properties.
  - **`data`** *(object)*
    - **`infrastructure`** *(object)*
      - **`arn`** *(string)*: Amazon Resource Name.

        Examples:
        ```json
        "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
        ```

        ```json
        "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
        ```

    - **`security`** *(object)*: Informs downstream services of network and/or IAM policies. Cannot contain additional properties.
      - **`iam`** *(object)*: IAM Policies. Cannot contain additional properties.
        - **`^[a-z]+[a-z_]*[a-z]+$`** *(object)*
          - **`policy_arn`** *(string)*: AWS IAM policy ARN.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

      - **`identity`** *(object)*: For instances where IAM policies must be attached to a role attached to an AWS resource, for instance AWS Eventbridge to Firehose, this attribute should be used to allow the downstream to attach it's policies (Firehose) directly to the IAM role created by the upstream (Eventbridge). It is important to remember that connections in massdriver are one way, this scheme perserves the dependency relationship while allowing bundles to control the lifecycles of resources under it's management. Cannot contain additional properties.
        - **`role_arn`** *(string)*: ARN for this resources IAM Role.

          Examples:
          ```json
          "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
          ```

          ```json
          "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
          ```

      - **`network`** *(object)*: AWS security group rules to inform downstream services of ports to open for communication. Cannot contain additional properties.
        - **`^[a-z-]+$`** *(object)*
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

          - **`port`** *(integer)*: Port number. Minimum: `0`. Maximum: `65535`.
          - **`protocol`** *(string)*: Must be one of: `['tcp', 'udp']`.
  - **`specs`** *(object)*
    - **`aws`** *(object)*: .
      - **`region`** *(string)*: AWS Region to provision in.

        Examples:
        ```json
        "us-west-2"
        ```

- **`vpc`** *(object)*: . Cannot contain additional properties.
  - **`data`** *(object)*
    - **`infrastructure`** *(object)*
      - **`arn`** *(string)*: Amazon Resource Name.

        Examples:
        ```json
        "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
        ```

        ```json
        "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
        ```

      - **`cidr`** *(string)*

        Examples:
        ```json
        "10.100.0.0/16"
        ```

        ```json
        "192.24.12.0/22"
        ```

      - **`internal_subnets`** *(array)*
        - **Items** *(object)*: AWS VCP Subnet.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

          - **`aws_zone`** *(string)*: AWS Availability Zone.

            Examples:
          - **`cidr`** *(string)*

            Examples:
            ```json
            "10.100.0.0/16"
            ```

            ```json
            "192.24.12.0/22"
            ```


          Examples:
      - **`private_subnets`** *(array)*
        - **Items** *(object)*: AWS VCP Subnet.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

          - **`aws_zone`** *(string)*: AWS Availability Zone.

            Examples:
          - **`cidr`** *(string)*

            Examples:
            ```json
            "10.100.0.0/16"
            ```

            ```json
            "192.24.12.0/22"
            ```


          Examples:
      - **`public_subnets`** *(array)*
        - **Items** *(object)*: AWS VCP Subnet.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

          - **`aws_zone`** *(string)*: AWS Availability Zone.

            Examples:
          - **`cidr`** *(string)*

            Examples:
            ```json
            "10.100.0.0/16"
            ```

            ```json
            "192.24.12.0/22"
            ```


          Examples:
  - **`specs`** *(object)*
    - **`aws`** *(object)*: .
      - **`region`** *(string)*: AWS Region to provision in.

        Examples:
        ```json
        "us-west-2"
        ```

<!-- CONNECTIONS:END -->

</details>

### Artifacts

Resources created by this bundle that can be connected to other bundles.

<details>
<summary>View</summary>

<!-- ARTIFACTS:START -->
<!-- ARTIFACTS:END -->

</details>

## Contributing

<!-- CONTRIBUTING:START -->

### Bug Reports & Feature Requests

Did we miss something? Please [submit an issue](https://github.com/massdriver-cloud/aws-sagemaker-inference-endpoint/issues>) to report any bugs or request additional features.

### Developing

**Note**: Massdriver bundles are intended to be tightly use-case scoped, intention-based, reusable pieces of IaC for use in the [Massdriver][website] platform. For this reason, major feature additions that broaden the scope of an existing bundle are likely to be rejected by the community.

Still want to get involved? First check out our [contribution guidelines](https://docs.massdriver.cloud/bundles/contributing).

### Fix or Fork

If your use-case isn't covered by this bundle, you can still get involved! Massdriver is designed to be an extensible platform. Fork this bundle, or [create your own bundle from scratch](https://docs.massdriver.cloud/bundles/development)!

<!-- CONTRIBUTING:END -->

## Connect

<!-- CONNECT:START -->

Questions? Concerns? Adulations? We'd love to hear from you!

Please connect with us!

[![Email][email_shield]][email_url]
[![GitHub][github_shield]][github_url]
[![LinkedIn][linkedin_shield]][linkedin_url]
[![Twitter][twitter_shield]][twitter_url]
[![YouTube][youtube_shield]][youtube_url]
[![Reddit][reddit_shield]][reddit_url]


<!-- markdownlint-disable -->

[logo]: https://raw.githubusercontent.com/massdriver-cloud/docs/main/static/img/logo-with-logotype-horizontal-400x110.svg

[docs]: https://docs.massdriver.cloud?utm_source=aws-sagemaker-inference-endpoint&utm_medium=aws-sagemaker-inference-endpoint&utm_campaign=aws-sagemaker-inference-endpoint&utm_content=aws-sagemaker-inference-endpoint
[website]: https://www.massdriver.cloud?utm_source=aws-sagemaker-inference-endpoint&utm_medium=aws-sagemaker-inference-endpoint&utm_campaign=aws-sagemaker-inference-endpoint&utm_content=aws-sagemaker-inference-endpoint
[github]: https://github.com/massdriver-cloud
[linkedin]: https://www.linkedin.com/company/massdriver/

[contributors_shield]: https://img.shields.io/github/contributors/massdriver-cloud/aws-sagemaker-inference-endpoint.svg?style=for-the-badge>
[contributors_url]: https://github.com/massdriver-cloud/aws-sagemaker-inference-endpoint/graphs/contributors>
[forks_shield]: https://img.shields.io/github/forks/massdriver-cloud/aws-sagemaker-inference-endpoint.svg?style=for-the-badge>
[forks_url]: https://github.com/massdriver-cloud/aws-sagemaker-inference-endpoint/network/members>
[stars_shield]: https://img.shields.io/github/stars/massdriver-cloud/aws-sagemaker-inference-endpoint.svg?style=for-the-badge>
[stars_url]: https://github.com/massdriver-cloud/aws-sagemaker-inference-endpoint/stargazers>
[issues_shield]: https://img.shields.io/github/issues/massdriver-cloud/aws-sagemaker-inference-endpoint.svg?style=for-the-badge>
[issues_url]: https://github.com/massdriver-cloud/aws-sagemaker-inference-endpoint/issues>
[release_url]: https://github.com/massdriver-cloud/aws-sagemaker-inference-endpoint/releases/latest>
[release_shield]: https://img.shields.io/github/release/massdriver-cloud/aws-sagemaker-inference-endpoint.svg?style=for-the-badge>
[license_shield]: https://img.shields.io/github/license/massdriver-cloud/aws-sagemaker-inference-endpoint.svg?style=for-the-badge>
[license_url]: https://github.com/massdriver-cloud/aws-sagemaker-inference-endpoint/blob/main/LICENSE>

[email_url]: mailto:support@massdriver.cloud
[email_shield]: https://img.shields.io/badge/email-Massdriver-black.svg?style=for-the-badge&logo=mail.ru&color=000000
[github_url]: mailto:support@massdriver.cloud
[github_shield]: https://img.shields.io/badge/follow-Github-black.svg?style=for-the-badge&logo=github&color=181717
[linkedin_url]: https://linkedin.com/in/massdriver-cloud
[linkedin_shield]: https://img.shields.io/badge/follow-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&color=0A66C2
[twitter_url]: https://twitter.com/massdriver
[twitter_shield]: https://img.shields.io/badge/follow-Twitter-black.svg?style=for-the-badge&logo=twitter&color=1DA1F2
[youtube_url]: https://www.youtube.com/channel/UCfj8P7MJcdlem2DJpvymtaQ
[youtube_shield]: https://img.shields.io/badge/subscribe-Youtube-black.svg?style=for-the-badge&logo=youtube&color=FF0000
[reddit_url]: https://www.reddit.com/r/massdriver
[reddit_shield]: https://img.shields.io/badge/subscribe-Reddit-black.svg?style=for-the-badge&logo=reddit&color=FF4500

<!-- markdownlint-restore -->

<!-- CONNECT:END -->
