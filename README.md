# terraform_aws_web_service
A simple terraform configuration for deploying a 2 tier application inside a custom VPC with 4 subnets (2 private 2 public) containing an ELB internet facing and 2 ec2 instances within private subnets in different AZs

This terraform configuration:

1. Creates a custom VPC (CIDR 10.0.0.0/16) using the official VPC module from https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
2. Creates 2 private and public subnets
4. Creates internet facing ELB to process http requests.
5. Creates security group for the ELB to permit inbound http request from the internet
5. Creates security group for the instances to permit inbound http requests comming from the ELB
7. Creates a pool of instances to be deployed in the private subnets
8. Prints output variables in console after terraform apply command for checking the entry point (application url) of our app

The image below is an example of how the application must render and be accesible from the web browser.

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
