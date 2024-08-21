

data "aws_availability_zones" "available" {
  state = "available"
}

#Import vpc modules
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.7.0"

  cidr = var.aws_vpc_cidr_block

  azs = data.aws_availability_zones.available.names

  private_subnets = slice(var.aws_private_subnet_cidr_blocks, 0, var.aws_private_subnet_count)
  public_subnets  = slice(var.aws_public_subnet_cidr_blocks, 0, var.aws_public_subnet_count)

  enable_nat_gateway = var.aws_enable_nat_gateway
  enable_vpn_gateway = var.aws_enable_vpn_gateway
  tags               = merge(
    { Name = "VPC-${var.aws_resource_tags["project"]}-${var.aws_resource_tags["environment"]}"}, 
    var.aws_resource_tags)
}

module "app_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/web"
  version = "4.17.0"

  name        = "web-sg-${var.aws_resource_tags["project"]}-${var.aws_resource_tags["environment"]}"
  description = "Security group for web-servers with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = module.vpc.public_subnets_cidr_blocks

  tags = var.aws_resource_tags
}

module "lb_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/web"
  version = "4.17.0"

  name        = "lb-sg-${var.aws_resource_tags["project"]}-${var.aws_resource_tags["environment"]}"
  description = "Security group for load balancer with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]

  tags = var.aws_resource_tags
}

resource "random_string" "lb_id" {
  length  = 3
  special = false
}

module "elb_http" {
  source  = "terraform-aws-modules/elb/aws"
  version = "4.0.1"

  # Ensure load balancer name is unique
  name = "lb-${random_string.lb_id.result}-${var.aws_resource_tags["project"]}-${var.aws_resource_tags["environment"]}"

  internal = false

  security_groups = [module.lb_security_group.security_group_id]
  subnets         = module.vpc.public_subnets

  number_of_instances = length(module.ec2_instances.instance_ids)
  instances           = module.ec2_instances.instance_ids

  listener = [{
    instance_port     = "80"
    instance_protocol = "HTTP"
    lb_port           = "80"
    lb_protocol       = "HTTP"
  }]

  health_check = {
    target              = "HTTP:80/index.php"
    interval            = 10
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
  }

  tags = var.aws_resource_tags
}

module "ec2_instances" {
  source = "./modules/aws-instance"

  depends_on = [module.vpc]

  instance_count     = var.aws_instance_count
  instance_ami       = var.aws_instance_ami
  instance_type      = var.aws_instance_type
  subnet_ids         = module.vpc.private_subnets[*]
  security_group_ids = [module.app_security_group.security_group_id]

  tags = var.aws_resource_tags
}
