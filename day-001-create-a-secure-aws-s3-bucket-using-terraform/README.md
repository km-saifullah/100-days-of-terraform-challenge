# Day 01: Provision a Secure AWS S3 Bucket Using Terraform

## Problem Statement

Organizations require reliable and secure cloud storage to manage application files, documents, backups, and other important data.

Traditionally, cloud infrastructure is often created manually through the AWS Management Console. However, manually managing infrastructure can introduce configuration inconsistencies, human errors, security risks, and difficulties when recreating or maintaining resources.

The objective of this project is to provision an Amazon S3 bucket using Terraform, following Infrastructure as Code (IaC) principles.

The S3 bucket must be private, encrypted, and protected against accidental public access. All infrastructure configurations must be defined in Terraform files to ensure consistency, repeatability, and easier infrastructure management.

This project is the first step in the 100 Days of AWS and Terraform learning journey.

## Technology Used

| Technology   | Purpose                                      |
| ------------ | -------------------------------------------- |
| AWS          | Cloud infrastructure                         |
| Amazon S3    | Object storage                               |
| Terraform    | Infrastructure as Code                       |
| AWS Provider | Connects Terraform with AWS                  |
| AWS CLI      | AWS authentication and resource verification |
| HCL          | Terraform configuration language             |

## Project Objectives

- Provision an Amazon S3 bucket using Terraform
- Configure AWS provider and region
- Understand Terraform resources and variables
- Enable server-side encryption
- Block all public access
- Apply appropriate resource tags
- Retrieve resource information using Terraform outputs
- Understand the Terraform infrastructure lifecycle

## Features

### 1. Infrastructure as Code

All infrastructure resources are defined using Terraform configuration files instead of manual AWS Console operations.

### 2. Private S3 Bucket

The S3 bucket is configured to prevent public access.

### 3. Server-Side Encryption

Server-side encryption using AES256 (SSE-S3) is enabled to protect stored objects.

### 4. Public Access Protection

All four S3 public access block settings are enabled to prevent accidental public exposure.

### 5. Reusable Configuration

Terraform variables allow the AWS region, bucket name, and environment to be configured independently.

### 6. Infrastructure Outputs

Terraform outputs display the bucket name, ARN, region, and security configuration after deployment.

### 7. Resource Tagging

AWS resources are tagged for identification, organization, and infrastructure management.

## Which Problems Does This Project Solve?

This project addresses several common infrastructure management challenges.

**Manual Infrastructure Management:** Terraform automates resource provisioning and reduces repetitive manual operations.

**Configuration Inconsistency:** Infrastructure configurations are maintained in version-controlled code, making them easier to reproduce.

**Accidental Public Exposure:** S3 public access blocking provides protection against unintended public access.

**Unencrypted Storage:** Server-side encryption protects stored objects.

**Limited Infrastructure Visibility:** Terraform outputs provide important information about provisioned resources.

**Difficult Resource Recreation:** The same Terraform configuration can be used to recreate the infrastructure.

## Project Architecture

```text
                  Engineer
                      |
                      v
              Terraform Files
                      |
                      v
              Terraform CLI
                      |
                      v
               AWS Provider
                      |
                      v
               Amazon S3
                      |
          +-----------+-----------+
          |           |           |
          v           v           v
      Encryption  Public Access   Tags
                    Block
```

## Project Directory Structure

```text
day-01-secure-s3-bucket/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── .gitignore
│
└── README.md
```

## Steps for the Solution

### Step 1: Install Prerequisites

Install the following tools

- AWS CLI
- Terraform CLI
- Git

Verify the installations

```bash
aws --version
terraform --version
git --version
```

### Step 2: Configure AWS Authentication

Configure your AWS credentials using the AWS CLI

```bash
aws configure
```

Provide the required AWS credentials and default region.

For production environments, prefer IAM roles or AWS IAM Identity Center instead of long-lived access keys.

Verify AWS authentication

```bash
aws sts get-caller-identity
```

### Step 3: Create the Project Directory

```bash
mkdir day-01-secure-s3-bucket

cd day-01-secure-s3-bucket
```

Create the required Terraform files

```bash
touch main.tf variables.tf outputs.tf terraform.tfvars .gitignore README.md
```

### Step 4: Configure Terraform Files

Add the Terraform configuration to the corresponding files

- `main.tf`: AWS provider and S3 resources
- `variables.tf`: Input variables and validation
- `outputs.tf`: Infrastructure outputs
- `terraform.tfvars`: Project configuration
- `.gitignore`: Files excluded from Git tracking

Update the bucket name in `terraform.tfvars` to a globally unique name.

### Step 5: Initialize Terraform

Initialize the Terraform working directory

```bash
terraform init
```

This command downloads the required AWS provider and initializes the Terraform project.

### Step 6: Validate Terraform Configuration

```bash
terraform validate
```

This checks whether the Terraform configuration is syntactically valid.

### Step 7: Format Terraform Files

```bash
terraform fmt -recursive
```

This formats the Terraform files according to standard Terraform formatting conventions.

### Step 8: Review the Execution Plan

```bash
terraform plan
```

Review the resources Terraform intends to create.

Check that the configuration includes:

- One S3 bucket
- One public access block configuration
- One server-side encryption configuration

### Step 9: Provision AWS Infrastructure

```bash
terraform apply
```

Review the proposed changes and enter `yes` when prompted.

Terraform will provision the S3 bucket and apply the security configurations.

### Step 10: Verify Terraform Outputs

```bash
terraform output
```

Retrieve individual outputs

```bash
terraform output s3_bucket_name
terraform output s3_bucket_arn
terraform output s3_bucket_region
terraform output s3_bucket_security_status
```

### Step 11: Verify Resources in AWS

Check the bucket

```bash
aws s3api head-bucket \
  --bucket YOUR_BUCKET_NAME
```

Check public access protection

```bash
aws s3api get-public-access-block \
  --bucket YOUR_BUCKET_NAME
```

Check encryption

```bash
aws s3api get-bucket-encryption \
  --bucket YOUR_BUCKET_NAME
```

Replace `YOUR_BUCKET_NAME` with your actual bucket name.

### Step 12: Verify Terraform State

```bash
terraform state list
```

Expected resources

```text
aws_s3_bucket.secure_bucket
aws_s3_bucket_public_access_block.secure_bucket
aws_s3_bucket_server_side_encryption_configuration.secure_bucket
```

### Step 13: Destroy the Infrastructure

After completing the project and verification, remove the AWS resources

```bash
terraform destroy
```

Review the resources and enter `yes` when prompted.

This prevents unnecessary ongoing AWS resource charges.

## Important Terraform Commands

| Command                | Description                       |
| ---------------------- | --------------------------------- |
| `terraform init`       | Initializes Terraform             |
| `terraform fmt`        | Formats configuration files       |
| `terraform validate`   | Validates Terraform configuration |
| `terraform plan`       | Previews infrastructure changes   |
| `terraform apply`      | Creates or updates infrastructure |
| `terraform output`     | Displays output values            |
| `terraform state list` | Lists managed resources           |
| `terraform destroy`    | Removes managed infrastructure    |

## Security Considerations

- Never commit AWS access keys or secrets to GitHub
- Never commit Terraform state files to a public repository
- Keep S3 public access blocking enabled unless there is a specific approved requirement
- Use least-privilege IAM permissions
- Review Terraform plans before applying infrastructure changes
- Destroy unused AWS resources to prevent unnecessary costs

## Cost Considerations

This project uses Amazon S3, which may incur charges depending on the AWS account's eligibility, storage usage, requests, and applicable pricing.

The Terraform CLI and AWS provider do not require a paid license.

Always review the current AWS pricing and available Free Tier benefits before deploying resources.

## Learning Outcomes

After completing this project, you should understand

1. What Infrastructure as Code means
2. How Terraform communicates with AWS
3. How to configure an AWS provider
4. How Terraform resources work
5. How to define and use variables
6. How to retrieve resource attributes using outputs
7. How Terraform manages resource dependencies
8. How to provision and destroy AWS infrastructure
9. How to apply basic security configurations to S3

## Conclusion

Successfully completed the first project of the 100 Days of AWS and Terraform learning journey. The required AWS infrastructure was provisioned, configured, and verified using Terraform.

This project establishes the foundation for learning AWS services, Infrastructure as Code, and automated cloud infrastructure management.
