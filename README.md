# terraform_aws_web_service
A simple terraform configuration for deploying a 2 tier application composed of an ELB interface facing and 2 ec2 instances is different AZs

This terraform configuration:

1. Creates a custom VPC (CIDR 10.0.0.0/16) using the official VPC module from https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
2. Creates 2 private and public subnets
4. Creates internet facing ELB to process http requests.
5. Creates security group for the ELB to permit inbound http request from the internet
7. Creates a pool of instances to be deployed in the private subnet
8. Prints output variables in console after terraform apply command for checking the entry point (application url) of our app

The image below is an example of how the application must render and be accesible from the web browser.

<p align="center">
  <img src="https://github.com/user-attachments/assets/a3a54901-c57f-452f-a215-44696c72eff4" height=400>
  <br>
  <em>Figure 1. Instance Metadata</em>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/a3a54901-c57f-452f-a215-44696c72eff4" height=400>
  <br>
  <em>Figure 2. App service</em>
</p>
