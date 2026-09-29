# Day 02: Upload and Manage S3 Objects Using Terraform

## Problem Statement

Organizations frequently use Amazon S3 to store application files, documents, configuration files, backups, and static assets.

Although Amazon S3 provides reliable cloud storage, manually uploading and managing objects through the AWS Management Console can become repetitive and difficult to maintain.

Manual operations can introduce configuration inconsistencies, human errors, and difficulties when managing files across multiple environments.

The objective of this project is to automate S3 object management using Terraform.

Building upon Day 01, this project demonstrates how to provision an S3 bucket and upload multiple local files using Terraform Infrastructure as Code.

The infrastructure must support automated file uploads, organized object keys, appropriate content types, and Terraform-based change detection.

## Technology Used

| Technology   | Purpose                                     |
| ------------ | ------------------------------------------- |
| AWS          | Cloud infrastructure provider               |
| Amazon S3    | Object storage service                      |
| Terraform    | Infrastructure as Code                      |
| AWS Provider | Connects Terraform with AWS                 |
| AWS CLI      | Resource verification and object inspection |
| HCL          | Terraform configuration language            |

## Project Objectives

- Create an Amazon S3 bucket using Terraform
- Configure bucket security settings
- Upload multiple local files into S3
- Organize uploaded objects using object keys
- Manage multiple objects using Terraform
- Assign appropriate content types
- Detect local file modifications
- Retrieve uploaded object information using Terraform outputs
- Verify S3 objects using AWS CLI
- Understand Terraform resource lifecycle management

## Features

### 1. Automated S3 Bucket Provisioning

Creates an Amazon S3 bucket using Terraform configuration files.

### 2. Automated File Upload

Uploads multiple local files to Amazon S3 without requiring manual console operations.

### 3. Multiple Object Management

Uses Terraform resource iteration to manage multiple S3 objects through a reusable configuration.

### 4. Organized Object Keys

Stores files under logical prefixes such as documents, configuration, and images.

### 5. Content Type Configuration

Assigns appropriate MIME types to uploaded files.

### 6. File Change Detection

Uses file checksums to help Terraform detect changes to local files.

### 7. Secure Storage

Enables server-side encryption and blocks public access to the S3 bucket.

### 8. Terraform Outputs

Displays bucket information and uploaded object keys after successful deployment.

### 9. Infrastructure Lifecycle Management

Supports creating, updating, and removing managed S3 objects through Terraform.

## Which Problems Does This Project Solve?

**Manual File Uploads:** Automates repetitive file-upload operations through Terraform.

**Configuration Inconsistency:** Maintains infrastructure and object configuration as code.

**Difficult File Management:** Organizes objects through consistent S3 key prefixes.

**Untracked File Changes:** Allows Terraform to detect changes in local files.

**Repetitive Resource Definitions:** Uses Terraform iteration to manage multiple objects without duplicating resource blocks.

**Limited Resource Visibility:** Provides outputs and AWS CLI verification methods for uploaded objects.

**Infrastructure Recreation:** Makes the bucket and its managed objects reproducible through Terraform.

## Project Architecture

```text
                  Cloud Engineer
                        |
                        v
                 Local Project Files
                        |
                        v
                Terraform Configuration
                        |
                        v
                  Terraform CLI
                        |
                        v
                   AWS Provider
                        |
                        v
                  Amazon S3 Bucket
                        |
          +-------------+-------------+
          |             |             |
          v             v             v
      Documents    Configuration    Images
          |             |             |
          +-------------+-------------+
                        |
                        v
                 Terraform Outputs
                        |
                        v
                  AWS CLI Verification
```

## Project Directory Structure

```text
day-02-s3-object-management/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── .gitignore
│
├── files/
│   ├── documents/
│   │   ├── welcome.txt
│   │   └── company-info.txt
│   │
│   ├── configuration/
│   │   └── app-config.json
│   │
│   └── images/
│       └── logo.svg
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

Configure AWS credentials

```bash
aws configure
```

Verify authentication

```bash
aws sts get-caller-identity
```

For production environments, prefer IAM roles or AWS IAM Identity Center instead of long-lived access keys.

### Step 3: Create the Project Directory

```bash
mkdir day-02-s3-object-management

cd day-02-s3-object-management
```

Create the required directories

```bash
mkdir -p files/documents
mkdir -p files/configuration
mkdir -p files/images
```

### Step 4: Create Terraform Configuration Files

Create the following files

```bash
touch main.tf variables.tf outputs.tf terraform.tfvars .gitignore README.md
```

Add the Terraform configurations to their respective files.

### Step 5: Create Sample Files

Create the following sample files

```text
files/documents/welcome.txt
files/documents/company-info.txt
files/configuration/app-config.json
files/images/logo.svg
```

Add sample content to each file.

### Step 6: Configure Project Variables

Update `terraform.tfvars` with the desired AWS region, unique bucket name, and environment.

### Step 7: Initialize Terraform

```bash
terraform init
```

This downloads the required AWS provider and initializes the working directory.

### Step 8: Format and Validate

```bash
terraform fmt -recursive
terraform validate
```

This ensures that the Terraform configuration follows standard formatting and is syntactically valid.

### Step 9: Review the Execution Plan

```bash
terraform plan
```

Review the proposed infrastructure changes.

The initial deployment should include

- One S3 bucket
- One public access block configuration
- One encryption configuration
- Four S3 objects

### Step 10: Deploy Infrastructure

```bash
terraform apply
```

Review the proposed changes and enter `yes` when prompted.

Terraform will provision the bucket and upload the configured files.

### Step 11: Verify Terraform Outputs

```bash
terraform output
```

Review the bucket name, ARN, uploaded object keys, and object URLs.

### Step 12: Verify Uploaded Objects

```bash
aws s3 ls s3://YOUR_BUCKET_NAME --recursive
```

Replace `YOUR_BUCKET_NAME` with your actual bucket name.

Verify an individual object

```bash
aws s3api head-object \
  --bucket YOUR_BUCKET_NAME \
  --key documents/welcome.txt
```

### Step 13: Test File Change Detection

Modify the contents of

```text
files/documents/welcome.txt
```

Run

```bash
terraform plan
```

Review the proposed update.

Apply the changes

```bash
terraform apply
```

Verify the updated object

```bash
aws s3 cp \
  s3://YOUR_BUCKET_NAME/documents/welcome.txt \
  -
```

### Step 14: Verify Terraform State

```bash
terraform state list
```

The expected managed resources include

```text
aws_s3_bucket.storage_bucket

aws_s3_bucket_public_access_block.storage_bucket

aws_s3_bucket_server_side_encryption_configuration.storage_bucket

aws_s3_object.uploaded_files["files/documents/welcome.txt"]

aws_s3_object.uploaded_files["files/documents/company-info.txt"]

aws_s3_object.uploaded_files["files/configuration/app-config.json"]

aws_s3_object.uploaded_files["files/images/logo.svg"]
```

### Step 15: Destroy the Infrastructure

After completing the project:

```bash
terraform destroy
```

Review the proposed changes and enter `yes`.

Ensure that all managed objects are removed before the bucket is deleted.

## Important Terraform Commands

| Command                | Description                       |
| ---------------------- | --------------------------------- |
| `terraform init`       | Initializes the project           |
| `terraform fmt`        | Formats Terraform files           |
| `terraform validate`   | Validates configuration           |
| `terraform plan`       | Previews infrastructure changes   |
| `terraform apply`      | Creates or updates infrastructure |
| `terraform output`     | Displays output values            |
| `terraform state list` | Lists managed resources           |
| `terraform destroy`    | Removes managed infrastructure    |

## Security Considerations

- Never commit AWS credentials to GitHub.
- Never commit Terraform state files.
- Keep S3 public access blocking enabled.
- Use least-privilege IAM permissions.
- Avoid uploading sensitive information into sample storage buckets.
- Review Terraform plans before applying changes.
- Destroy unused resources after completing the project.

## Cost Considerations

This project uses Amazon S3, which may incur charges depending on storage usage, requests, data transfer, account eligibility, and applicable AWS pricing.

Terraform CLI and the AWS provider do not require a paid license.

Review AWS pricing and applicable Free Tier benefits before deploying infrastructure.

## Learning Outcomes

After completing this project, you should understand

1. How Amazon S3 stores objects
2. The difference between an S3 bucket and an S3 object
3. How to upload local files using Terraform
4. How to use Terraform `for_each`
5. How to use Terraform variables with maps
6. How to reference local files using `path.module`
7. How to detect file changes using checksums
8. How to assign content types to S3 objects
9. How to manage resource dependencies
10. How to inspect uploaded objects using AWS CLI
11. How Terraform tracks multiple resources in its state
12. How to manage the infrastructure lifecycle

## Conclusion

Successfully completed Day 02 of the 100 Days of AWS and Terraform learning journey.

The required S3 infrastructure and sample objects were provisioned, managed, and verified using Terraform.

This project introduces automated object management and prepares the foundation for more advanced AWS storage, networking, and infrastructure automation projects.
