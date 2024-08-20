terraform {
  required_version = ">= 0.12" #Required terraform version
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.63.0"
    }
  }

  backend "s3" {
    bucket  = "terraform-aws-service-infra"
    key     = "terraform-variables-project/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }

}

provider "random" {}

provider "aws" {
  region = "us-east-1"
}
