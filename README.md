# AWS Web Service Infrastructure with Terraform

This Terraform project deploys a scalable web application infrastructure on AWS, featuring a two-tier architecture with load balancing and private instances for enhanced security.

## Architecture Overview

The infrastructure consists of:

- **Custom VPC** with CIDR block 10.0.0.0/16
- **Network Segmentation**: 2 public and 2 private subnets across different availability zones
- **Load Balancing**: Internet-facing Classic ELB for HTTP traffic distribution
- **Compute**: EC2 instances deployed in private subnets for enhanced security
- **Security**: Separate security groups for load balancer and application instances

## Infrastructure Components

| Component | Description |
|-----------|-------------|
| VPC | Custom network with 10.0.0.0/16 CIDR |
| Public Subnets | For internet-facing resources like load balancers |
| Private Subnets | For application instances, protected from direct internet access |
| NAT Gateway | Enables outbound internet access for private instances |
| Security Groups | Traffic control for load balancer and instances |
| EC2 Instances | Amazon Linux 2023 instances running Apache and PHP |
| Load Balancer | Classic ELB distributing traffic to instances |

## Modules Used

- **VPC**: [terraform-aws-modules/vpc/aws](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)
- **Security Group**: [terraform-aws-modules/security-group/aws](https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest)
- **ELB**: [terraform-aws-modules/elb/aws](https://registry.terraform.io/modules/terraform-aws-modules/elb/aws/latest)
- **EC2 Instances**: Custom module for instance provisioning

## Application Details

The deployed application:
- Runs on Apache with PHP
- Displays EC2 instance metadata (instance ID, AMI, IP addresses, etc.)
- Includes the Terramino game demo

## Usage

### Prerequisites

- Terraform installed (version 1.0.0+)
- AWS CLI configured with appropriate credentials
- SSH key pair for instance access

### Deployment Steps

1. Clone this repository
2. Initialize Terraform:
   ```
   terraform init
   ```
3. Review the execution plan:
   ```
   terraform plan
   ```
4. Apply the configuration:
   ```
   terraform apply
   ```
5. Access the application using the ELB DNS name from the outputs:
   ```
   terraform output elb_public_dns_name
   ```

### Customization

The infrastructure can be customized through variables in `variables.tf`:

- `aws_region`: AWS region for deployment (default: us-east-1)
- `aws_instance_count`: Number of EC2 instances (default: 3)
- `aws_instance_type`: EC2 instance size (default: t2.micro)
- `aws_resource_tags`: Tags for resource organization and tracking

## Screenshots

<p align="center">
  <img src="https://github.com/user-attachments/assets/ded7e83a-7b23-4819-88f5-cf0681473f74" height=400>
  <br>
  <em>Figure 1. Instance Metadata</em>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/8c76422f-359e-43a4-b481-d94625a18c26" height=400>
  <br>
  <em>Figure 2. App service</em>
</p>

