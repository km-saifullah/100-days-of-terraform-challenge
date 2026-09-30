# Day 03: Host a Static Website Using Amazon S3 and Terraform

## Problem Statement

Organizations and small businesses often need to host static websites to showcase their services, products, company information, and contact details.

Traditionally, hosting a website requires configuring web servers, managing operating systems, maintaining infrastructure, and handling deployment processes.

However, websites containing only HTML, CSS, and JavaScript do not necessarily require a dedicated web server.

Amazon S3 provides static website hosting capabilities that allow organizations to host static website content directly from an S3 bucket.

The objective of this project is to automate the deployment of a static website using Terraform and Amazon S3.

The infrastructure must support static website hosting, automated file uploads, public read access, and a custom error document.

This project is the third challenge of the 100 Days of AWS and Terraform learning journey.

## Technology Used

| Technology   | Purpose                          |
| ------------ | -------------------------------- |
| AWS          | Cloud infrastructure             |
| Amazon S3    | Static website hosting           |
| Terraform    | Infrastructure as Code           |
| AWS Provider | AWS resource management          |
| HCL          | Terraform configuration language |
| HTML         | Website structure                |
| CSS          | Website styling                  |
| AWS CLI      | Infrastructure verification      |
| Git          | Version control                  |

## Project Objectives

- Provision an Amazon S3 bucket using Terraform
- Enable static website hosting
- Configure an index document
- Configure a custom error document
- Upload HTML and CSS files automatically
- Configure public read-only access
- Apply appropriate content types
- Generate the website endpoint dynamically
- Verify website accessibility through a browser
- Understand the security implications of public S3 hosting
- Manage the infrastructure lifecycle using Terraform

## Features

### 1. Infrastructure as Code

All AWS infrastructure is defined and managed using Terraform.

### 2. Static Website Hosting

Configures Amazon S3 to serve static website content without requiring an EC2 instance or traditional web server.

### 3. Automated Website Deployment

Automatically uploads HTML and CSS files into the S3 bucket using Terraform.

### 4. Custom Homepage

Provides a professional landing page containing company information, services, and contact details.

### 5. Custom Error Page

Configures a dedicated error document for website requests that cannot be served successfully.

### 6. Public Read-Only Access

Configures an S3 bucket policy that allows website visitors to retrieve objects without granting write or delete permissions.

### 7. Automated Content Type Configuration

Assigns appropriate MIME types to HTML and CSS files.

### 8. Dynamic Website Endpoint

Uses Terraform outputs to retrieve the S3 static website endpoint.

### 9. Resource Tagging

Applies resource tags for identification and infrastructure management.

### 10. Infrastructure Lifecycle Management

Supports website creation, content updates, and infrastructure cleanup through Terraform.

## Which Problems Does This Project Solve?

**Traditional Web Server Management:** Eliminates the need to maintain a dedicated web server for a simple static website.

**Manual Website Deployment:** Automates website file uploads using Terraform.

**Configuration Inconsistency:** Maintains infrastructure configurations as code.

**Website Accessibility:** Configures public read-only access so visitors can access website content.

**Missing Error Handling:** Provides a custom error document for unsuccessful website requests.

**Difficult Infrastructure Recreation:** Allows the website infrastructure to be recreated using the same Terraform configuration.

**Limited Infrastructure Visibility:** Provides outputs containing the bucket name, ARN, and website endpoint.

## Project Architecture

```text
                 Cloud Engineer
                       |
                       v
                 Website Files
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
        +--------------+--------------+
        |              |              |
        v              v              v
    Website        Bucket Policy   Public Access
  Configuration     Read-Only        Settings
        |
        v
    S3 Website Endpoint
        |
        v
    Website Visitors
```

## Project Directory Structure

```text
day-03-s3-static-website/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── .gitignore
│
├── website/
│   ├── index.html
│   ├── error.html
│   └── style.css
│
└── README.md
```

## Steps for the Solution

### Step 1: Install Prerequisites

Install the following tools

- AWS CLI
- Terraform CLI
- Git
- A web browser

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
mkdir day-03-s3-static-website

cd day-03-s3-static-website
```

Create the website directory

```bash
mkdir website
```

Create the Terraform files

```bash
touch main.tf variables.tf outputs.tf terraform.tfvars .gitignore README.md
```

### Step 4: Create Website Files

Create the following files

```text
website/index.html
website/error.html
website/style.css
```

Add the provided HTML and CSS configurations.

### Step 5: Configure Terraform Variables

Update `terraform.tfvars` with:

- AWS region.
- Globally unique S3 bucket name.
- Environment name.

### Step 6: Initialize Terraform

```bash
terraform init
```

This initializes the Terraform working directory and downloads the required AWS provider.

### Step 7: Format and Validate

```bash
terraform fmt -recursive

terraform validate
```

This ensures that the configuration follows standard formatting and is syntactically valid.

### Step 8: Review Infrastructure Changes

```bash
terraform plan
```

Review the proposed resources before deployment.

The initial deployment should include

- One S3 bucket
- One static website configuration
- One public access block configuration
- One bucket policy
- Three website objects

### Step 9: Deploy Infrastructure

```bash
terraform apply
```

Review the proposed changes and enter `yes`.

Terraform will provision the required infrastructure and upload the website files.

### Step 10: Retrieve the Website Endpoint

```bash
terraform output website_endpoint
```

Copy the generated endpoint and open it in a browser.

The website should display the CloudNova landing page.

### Step 11: Verify Uploaded Website Files

```bash
aws s3 ls s3://YOUR_BUCKET_NAME
```

Replace `YOUR_BUCKET_NAME` with the actual bucket name.

Expected objects

```text
error.html
index.html
style.css
```

### Step 12: Verify Website Configuration

```bash
aws s3api get-bucket-website \
  --bucket YOUR_BUCKET_NAME
```

Verify that the index and error documents are configured correctly.

### Step 13: Verify Bucket Policy

```bash
aws s3api get-bucket-policy \
  --bucket YOUR_BUCKET_NAME \
  --query Policy \
  --output text
```

Ensure that the public policy grants only object read access.

### Step 14: Test Website Updates

Modify the contents of

```text
website/index.html
```

Run

```bash
terraform plan
```

Review the proposed changes and apply them

```bash
terraform apply
```

Refresh the website to verify the updated content.

### Step 15: Destroy Infrastructure

After completing the challenge

```bash
terraform destroy
```

Review the resources and enter `yes`.

This removes the managed website infrastructure and helps prevent unnecessary AWS charges.

## Important Terraform Commands

| Command                | Description                                        |
| ---------------------- | -------------------------------------------------- |
| `terraform init`       | Initializes Terraform                              |
| `terraform fmt`        | Formats Terraform configuration                    |
| `terraform validate`   | Validates configuration                            |
| `terraform plan`       | Previews infrastructure changes                    |
| `terraform apply`      | Creates or updates infrastructure                  |
| `terraform output`     | Displays website endpoint and resource information |
| `terraform state list` | Lists managed resources                            |
| `terraform destroy`    | Removes managed infrastructure                     |

## Security Considerations

- Public read access is intentionally enabled for website hosting
- Never upload sensitive information or credentials to this bucket
- Do not grant public write or delete permissions
- Keep public ACLs blocked
- Understand that account-level or organization-level security policies may prevent public access
- Do not weaken account-wide security controls just to complete this project
- S3 website endpoints use HTTP rather than HTTPS
- Use Amazon CloudFront when implementing HTTPS-based static website delivery
- Never commit AWS credentials or Terraform state files to GitHub

## Cost Considerations

Amazon S3 may incur charges depending on storage usage, requests, data transfer, account eligibility, and applicable AWS pricing.

Although this project uses a small number of static files, it is not guaranteed to be completely free.

Review AWS pricing and applicable Free Tier benefits before deployment.

Destroy unused infrastructure after completing the project.

## Learning Outcomes

After completing this project, you should understand

1. What static website hosting means
2. How Amazon S3 hosts static website content
3. The difference between S3 buckets and website endpoints
4. How to configure S3 website hosting using Terraform
5. How to configure index and error documents
6. How to manage public access settings
7. How S3 bucket policies work
8. How to configure public read-only object access
9. How to upload HTML and CSS files using Terraform
10. How to retrieve the website endpoint through Terraform outputs
11. How to verify website configurations using AWS CLI
12. Why HTTPS delivery requires additional infrastructure for S3 static website hosting

## Conclusion

Successfully completed Day 03 of the 100 Days of AWS and Terraform learning journey.

The static website infrastructure was provisioned, configured, and verified using Terraform and Amazon S3.

This project introduces static website hosting, S3 website configurations, bucket policies, and public access management, establishing the foundation for more advanced AWS infrastructure projects.
