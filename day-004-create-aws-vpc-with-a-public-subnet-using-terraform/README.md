# Day 04 — Create a Basic AWS VPC with Terraform

## What Is the Challenge?

The goal of this challenge is to create a basic AWS networking environment using Terraform.

The infrastructure includes a custom VPC, a public subnet, an Internet Gateway, a public route table, an internet route, and a route table association.

The public subnet is configured with a route to the Internet Gateway, creating the foundation required for launching internet-accessible workloads in future projects.

The entire infrastructure is managed using Terraform instead of being created manually through the AWS Console.

## Technology Used

- AWS VPC
- AWS Subnet
- AWS Internet Gateway
- AWS Route Table
- AWS Route Table Association
- Terraform
- HCL
- AWS CLI

## Project Objectives

The objectives of this challenge are to

- Create a custom VPC
- Configure a VPC CIDR range
- Create a public subnet
- Configure an Availability Zone
- Create an Internet Gateway
- Create a public route table
- Add a default route to the Internet Gateway
- Associate the route table with the public subnet
- Use Terraform variables and outputs
- Verify the infrastructure through Terraform and AWS CLI

## Features

- Infrastructure as Code using Terraform
- Custom VPC CIDR configuration
- Public subnet configuration
- Internet Gateway integration
- Public route table
- Default internet route
- Resource tagging
- Terraform input validation
- Terraform outputs for important resource IDs
- Easy infrastructure cleanup using `terraform destroy`

## Problem Solved

Manually creating AWS networking resources can become difficult to maintain as infrastructure grows.

This project solves that problem by defining the networking infrastructure as Terraform configuration.

The desired infrastructure can therefore be reviewed, planned, created, modified, and destroyed through Terraform.

## Architecture

```text
                         Internet
                            │
                            │
                    Internet Gateway
                            │
                            │
                ┌───────────▼───────────┐
                │         VPC           │
                │     10.0.0.0/16       │
                │                       │
                │   ┌───────────────┐   │
                │   │ Public Subnet │   │
                │   │ 10.0.1.0/24   │   │
                │   │               │   │
                │   │ Route Table   │   │
                │   └───────────────┘   │
                └───────────────────────┘
```

## Project Structure

```text
day-04-basic-vpc/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── .gitignore
└── README.md
```

## Solution

The infrastructure is divided into several Terraform resources.

### VPC

A custom VPC is created using the CIDR block

```text
10.0.0.0/16
```

### Public Subnet

A subnet is created inside the VPC

```text
10.0.1.0/24
```

The subnet is configured in the selected Availability Zone.

### Internet Gateway

An Internet Gateway is attached to the VPC.

### Route Table

A dedicated route table is created for the public subnet.

### Internet Route

The route table contains

```text
0.0.0.0/0 → Internet Gateway
```

This provides a route for internet-bound IPv4 traffic.

### Route Table Association

The public subnet is associated with the public route table.

## How to Solve the Challenge

### 1. Create the project directory

```bash
mkdir day-04-basic-vpc
cd day-04-basic-vpc
```

### 2. Create the Terraform files

Create

```text
main.tf
variables.tf
outputs.tf
terraform.tfvars
.gitignore
```

### 3. Configure AWS authentication

Verify the AWS identity

```bash
aws sts get-caller-identity
```

### 4. Initialize Terraform

```bash
terraform init
```

### 5. Format the Terraform configuration

```bash
terraform fmt
```

### 6. Validate the configuration

```bash
terraform validate
```

### 7. Review the execution plan

```bash
terraform plan
```

### 8. Create the infrastructure

```bash
terraform apply
```

Confirm the deployment with

```text
yes
```

### 9. Check Terraform outputs

```bash
terraform output
```

### 10. Verify the infrastructure

Use the AWS Console or AWS CLI to verify the VPC, subnet, Internet Gateway, and route table.

### 11. Clean up

When the challenge is complete

```bash
terraform destroy
```

## Terraform Commands

Initialize

```bash
terraform init
```

Format

```bash
terraform fmt
```

Validate

```bash
terraform validate
```

Create a plan

```bash
terraform plan
```

Apply the configuration

```bash
terraform apply
```

Display outputs

```bash
terraform output
```

Destroy the infrastructure

```bash
terraform destroy
```

## Verification Checklist

- [ ] Terraform initialized successfully
- [ ] Terraform configuration passed validation
- [ ] VPC was created
- [ ] Public subnet was created
- [ ] Internet Gateway was created
- [ ] Public route table was created
- [ ] `0.0.0.0/0` route points to the Internet Gateway
- [ ] Public subnet is associated with the route table
- [ ] Terraform outputs were verified
- [ ] AWS resources were inspected
- [ ] Infrastructure was destroyed after testing

## Security and Cost Considerations

This challenge creates networking resources only and does not launch an EC2 instance.

AWS networking resources such as VPCs, subnets, route tables, and Internet Gateways should still be removed when they are no longer needed, especially when continuing with hands-on labs.

Do not assume that every AWS service or configuration is free of charge. Always check the current AWS pricing and free-tier eligibility for your account and region.

## Main Takeaways

This challenge introduces the basic building blocks of AWS networking.

The most important relationship to understand is:

```text
VPC
 │
 ├── Subnet
 │
 ├── Internet Gateway
 │
 └── Route Table
       │
       └── 0.0.0.0/0 → Internet Gateway
```

Understanding this structure provides the foundation for the upcoming EC2, security group, private subnet, and multi-tier networking challenges.

## Conclusion

The basic AWS VPC networking environment was successfully created and managed using Terraform. The required networking resources were configured, verified, and cleaned up after testing.
