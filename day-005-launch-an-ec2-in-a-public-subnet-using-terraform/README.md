# Day 05 - Launch an EC2 Web Server Using Terraform

## What Is the Challenge?

The goal of this challenge is to deploy an Amazon EC2 web server inside a public AWS subnet using Terraform.

The infrastructure includes a custom VPC, public subnet, Internet Gateway, route table, Security Group, SSH key pair, and EC2 instance.

The EC2 instance automatically installs and starts Nginx using EC2 user data.

The Security Group allows HTTP traffic from the internet while restricting SSH access to the administrator's IP address.

## Technology Used

- AWS VPC
- AWS Subnet
- AWS Internet Gateway
- AWS Route Table
- AWS Security Group
- AWS EC2
- Amazon Linux 2023
- Nginx
- Terraform
- HCL
- AWS CLI

## Project Objectives

The objectives of this challenge are to:

- Create an AWS VPC.
- Create a public subnet.
- Configure internet routing.
- Create an EC2 Security Group.
- Restrict SSH access to an administrator IP.
- Allow HTTP web traffic.
- Create an AWS Key Pair.
- Launch an Amazon Linux EC2 instance.
- Assign a public IPv4 address.
- Install Nginx automatically.
- Deploy a simple web page.
- Verify the application through HTTP and SSH.
- Manage the complete infrastructure using Terraform.

## Features

- Infrastructure as Code using Terraform.
- Custom VPC networking.
- Public subnet configuration.
- Internet Gateway.
- Public route table.
- Security Group configuration.
- Restricted SSH access.
- Public HTTP access.
- EC2 instance provisioning.
- Dynamic Amazon Linux AMI lookup.
- Automatic Nginx installation.
- EC2 user data configuration.
- Terraform outputs for infrastructure information.
- Resource tagging.
- Easy cleanup using `terraform destroy`.

## Problem Solved

Manually launching EC2 instances and configuring networking can lead to inconsistent infrastructure and repetitive configuration.

This project solves the problem by defining the complete environment using Terraform.

The EC2 instance, networking, firewall rules, SSH key pair, and web server configuration can be created consistently through Infrastructure as Code.

## Architecture

```text
                         Internet
                            │
                    ┌───────┴────────┐
                    │                │
                  SSH :22          HTTP :80
                    │                │
                    ▼                ▼
              ┌──────────────────────────┐
              │      Security Group      │
              │                          │
              │ SSH  → Administrator IP  │
              │ HTTP → Internet          │
              └────────────┬─────────────┘
                           │
                     ┌─────▼─────┐
                     │    EC2    │
                     │   Nginx   │
                     └─────┬─────┘
                           │
                     Public Subnet
                      10.0.1.0/24
                           │
                     Route Table
                           │
                       0.0.0.0/0
                           │
                   Internet Gateway
                           │
                          VPC
                     10.0.0.0/16
```

## Project Structure

```text
day-05-ec2-public-server/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── problem-statement.txt
├── .gitignore
└── README.md
```

## Solution

The infrastructure is divided into networking, security, and compute components.

### Networking

A custom VPC and public subnet are created.

The public subnet is connected to the internet through an Internet Gateway and a route table containing a default route.

### Security

A Security Group controls traffic to the EC2 instance.

SSH access is restricted to the administrator's IP address.

HTTP access is allowed from the internet so that the web application can be reached publicly.

### Compute

An Amazon Linux 2023 EC2 instance is launched inside the public subnet.

The instance receives a public IPv4 address and uses a configured SSH key pair.

### Web Server

EC2 user data automatically installs and starts Nginx.

A simple HTML page is created during instance initialization.

## How to Solve the Challenge

### 1. Create the project directory

```bash
mkdir day-05-ec2-public-server
cd day-05-ec2-public-server
```

### 2. Create the Terraform files

Create the required Terraform configuration files and add the project configuration.

### 3. Create or use an SSH key

Verify an existing key:

```bash
ls ~/.ssh/
```

Or create one:

```bash
ssh-keygen -t ed25519 -C "terraform-day05"
```

### 4. Get the public key

```bash
cat ~/.ssh/id_ed25519.pub
```

Add the public key to `terraform.tfvars`.

### 5. Configure the administrator IP

Find the public IP address:

```bash
curl -4 https://ifconfig.me
```

Configure it using `/32`:

```hcl
admin_cidr = "YOUR.PUBLIC.IP/32"
```

### 6. Initialize Terraform

```bash
terraform init
```

### 7. Format the configuration

```bash
terraform fmt
```

### 8. Validate the configuration

```bash
terraform validate
```

### 9. Review the plan

```bash
terraform plan
```

### 10. Deploy the infrastructure

```bash
terraform apply
```

Confirm the deployment with:

```text
yes
```

### 11. Check the outputs

```bash
terraform output
```

### 12. Test the website

Use the generated website URL in a browser.

### 13. Test SSH

Use the generated public IP:

```bash
ssh -i ~/.ssh/id_ed25519 ec2-user@YOUR_EC2_PUBLIC_IP
```

### 14. Verify Nginx

```bash
sudo systemctl status nginx
```

### 15. Clean up

```bash
terraform destroy
```

## Terraform Commands

Initialize:

```bash
terraform init
```

Format:

```bash
terraform fmt
```

Validate:

```bash
terraform validate
```

Create a plan:

```bash
terraform plan
```

Deploy:

```bash
terraform apply
```

View outputs:

```bash
terraform output
```

Destroy:

```bash
terraform destroy
```

## Verification Checklist

- [ ] Terraform initialized successfully.
- [ ] Terraform configuration passed validation.
- [ ] VPC was created.
- [ ] Public subnet was created.
- [ ] Internet Gateway was created.
- [ ] Public route table was created.
- [ ] Internet route was created.
- [ ] Security Group was created.
- [ ] SSH access is restricted to the administrator IP.
- [ ] HTTP access is enabled.
- [ ] EC2 instance was created.
- [ ] EC2 received a public IPv4 address.
- [ ] Nginx was installed automatically.
- [ ] Nginx is running.
- [ ] Website is accessible through HTTP.
- [ ] SSH connection works.
- [ ] Terraform outputs were verified.
- [ ] Infrastructure was destroyed after testing.

## Security Considerations

SSH access should not normally be exposed to the entire internet.

The Security Group therefore restricts port 22 to the administrator's IP address.

HTTP is publicly accessible because the server is intended to provide a public web application.

The private SSH key must remain on the administrator's machine and should never be committed to Git.

The Terraform variable file containing environment-specific configuration should also be excluded from version control when it contains sensitive or environment-specific information.

## Cost Considerations

EC2 usage and related AWS resources may incur charges depending on the AWS account, region, instance type, and current AWS pricing or free-tier eligibility.

This is a learning environment, so the infrastructure should be destroyed after testing:

```bash
terraform destroy
```

Always verify the current AWS pricing and free-tier terms for your account before deploying resources.

## Learning Outcomes

After completing this challenge, you should understand the relationship between:

```text
VPC
 │
 └── Public Subnet
       │
       ├── Route Table
       │
       ├── Internet Gateway
       │
       ├── Security Group
       │
       └── EC2
```

You should also understand how Terraform can provision both infrastructure and initial server configuration.

## Conclusion

The EC2 web server environment was successfully created and managed using Terraform. The required networking, security, compute, and web server configuration were deployed, verified, and cleaned up after testing.
