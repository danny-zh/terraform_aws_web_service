variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "Aws default region"
}

# VPC Variables
variable "aws_vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16" #If modified the public and private subnets cirds needs to be updated too
}

variable "aws_enable_vpn_gateway" {
  description = "Enable a VPN gateway in your VPC."
  type        = bool
  default     = false
}

variable "aws_enable_nat_gateway" {
  description = "Enable a nat gateway in the public subnets of VPC"
  type        = bool
  default     = true
}

variable "aws_public_subnet_count" {
  description = "Number of public subnets in VPC."
  type        = number
  default     = 2
}

variable "aws_private_subnet_count" {
  description = "Number of private subnets in VPC."
  type        = number
  default     = 2
}

variable "aws_public_subnet_cidr_blocks" {
  description = "Available cidr blocks for public subnets in VPC."
  type        = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24",
    "10.0.7.0/24",
    "10.0.8.0/24",
  ]
}

variable "aws_private_subnet_cidr_blocks" {
  description = "Available cidr blocks for private subnets in VPC."
  type        = list(string)
  default = [
    "10.0.101.0/24",
    "10.0.102.0/24",
    "10.0.103.0/24",
    "10.0.104.0/24",
    "10.0.105.0/24",
    "10.0.106.0/24",
    "10.0.107.0/24",
    "10.0.108.0/24",
  ]
}

# Instance variables
variable "aws_instance_ami" {
  type        = string
  default     = "ami-0ae8f15ae66fe8cda"
  description = "Amazon Linux 2023 AMI."
}

variable "aws_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "t2 micro free eligible tier."
}

variable "aws_instance_count" {
  description = "Number of instances to provision."
  type        = number
  default     = 2
}

# Resource tags

variable "aws_resource_tags" {
  type        = map(string)
  description = "Tags to be applied to each resource this TF configuration creates."
  default = {
    project     = "project-alpha"
    version     = "1.2"
    environment = "prod"
    owner       = "dz@dzcol.com"
  }

  validation {
    condition     = length(var.aws_resource_tags["project"]) <= 16 && length(regexall("[^a-zA-Z0-9-]", var.aws_resource_tags["project"])) == 0
    error_message = "The project tag must be no more than 16 characters, and only contain letters, numbers, and hyphens."

  }

  validation {
    condition     = length(var.aws_resource_tags["environment"]) <= 4 && length(regexall("[^a-zA-Z0-9-]", var.aws_resource_tags["environment"])) == 0
    error_message = "The environment tag must be no more than 8 characters, and only contain letters, numbers, and hyphens."

  }

}