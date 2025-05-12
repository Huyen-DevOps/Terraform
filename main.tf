terraform {
  cloud {
    organization = "DevOps_Terraform_Basic"
    workspaces {
      name = "Mini-project"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }

  required_version = ">= 1.0.0"
}

provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "vpc" {
  source = "./modules/vpc"

  aws_region                     = var.aws_region
  public_subnets                 = var.public_subnets
  private_subnets                = var.private_subnets
  aws_internet_gateway_tags_name = var.aws_internet_gateway_tags_name
  destination_cidr_block         = var.destination_cidr_block
  cidr_block                     = var.cidr_block
  enable_dns_support             = var.enable_dns_support
  enable_dns_hostnames           = var.enable_dns_hostnames

  vpc_tags_name                 = var.vpc_tags_name
  public_a_tags_name            = var.public_a_tags_name
  public_b_tags_name            = var.public_b_tags_name
  private_a_tags_name           = var.private_a_tags_name
  private_b_tags_name           = var.private_b_tags_name
  map_public_ip_on_launch       = var.map_public_ip_on_launch
  route_table_public_tags_name  = var.route_table_public_tags_name
  route_table_private_tags_name = var.route_table_private_tags_name

  nat_instance_ami = var.nat_instance_ami
  key_name         = var.key_name
  name_prefix      = var.name_prefix
}

module "alb" {
  source                     = "./modules/alb"
  alb_name                   = var.alb_name
  public_subnets             = module.vpc.public_subnets
  vpc_id                     = module.vpc.vpc_id
  internal                   = var.internal
  load_balancer_type         = var.load_balancer_type
  enable_deletion_protection = var.enable_deletion_protection

  listener_port       = var.listener_port
  listener_protocol   = var.listener_protocol
  default_action_type = var.default_action_type

  target_group_port     = var.target_group_port
  target_group_protocol = var.target_group_protocol
  target_type           = var.target_type

  alb_sg_listener_from_port   = var.alb_sg_listener_from_port
  alb_sg_listener_to_port     = var.alb_sg_listener_to_port
  alb_sg_listener_protocol    = var.alb_sg_listener_protocol
  alb_sg_listener_cidr_blocks = var.alb_sg_listener_cidr_blocks

  alb_sg_listener_from_port_2   = var.alb_sg_listener_from_port_2
  alb_sg_listener_to_port_2     = var.alb_sg_listener_to_port_2
  alb_sg_listener_protocol_2    = var.alb_sg_listener_protocol_2
  alb_sg_listener_cidr_blocks_2 = var.alb_sg_listener_cidr_blocks_2

  alb_sg_egress_from_port   = var.alb_sg_egress_from_port
  alb_sg_egress_to_port     = var.alb_sg_egress_to_port
  alb_sg_egress_protocol    = var.alb_sg_egress_protocol
  alb_sg_egress_cidr_blocks = var.alb_sg_egress_cidr_blocks

  name_prefix               = var.name_prefix
  ec2_sg_listener_from_port = var.ec2_sg_listener_from_port
  ec2_sg_listener_to_port   = var.ec2_sg_listener_to_port
  ec2_sg_listener_protocol  = var.ec2_sg_listener_protocol

  ec2_sg_egress_from_port   = var.ec2_sg_egress_from_port
  ec2_sg_egress_to_port     = var.ec2_sg_egress_to_port
  ec2_sg_egress_protocol    = var.ec2_sg_egress_protocol
  ec2_sg_egress_cidr_blocks = var.ec2_sg_egress_cidr_blocks
}

module "ec2" {
  source                = "./modules/ec2"
  ami_id                = var.ami_id
  instance_type         = var.instance_type
  private_subnets       = module.vpc.private_subnets
  vpc_id                = module.vpc.vpc_id
  alb_security_group_id = module.alb.alb_security_group_id
  name_prefix           = var.name_prefix
  desired_capacity      = var.desired_capacity
  max_size              = var.max_size
  min_size              = var.min_size
  propagate_at_launch   = var.propagate_at_launch
  target_group_arns     = module.alb.target_group_arns

  ec2_sg_md_listener_from_port = var.ec2_sg_md_listener_from_port
  ec2_sg_md_listener_to_port   = var.ec2_sg_md_listener_to_port
  ec2_sg_md_listener_protocol  = var.ec2_sg_md_listener_protocol

  ec2_sg_md_egress_from_port   = var.ec2_sg_md_egress_from_port
  ec2_sg_md_egress_to_port     = var.ec2_sg_md_egress_to_port
  ec2_sg_md_egress_protocol    = var.ec2_sg_md_egress_protocol
  ec2_sg_md_egress_cidr_blocks = var.ec2_sg_md_egress_cidr_blocks
}
