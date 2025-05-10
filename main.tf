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


# Configure the AWS Provider
provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "vpc" {
  source          = "./modules/vpc"

  aws_region      = var.aws_region
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  aws_internet_gateway_tags_name = var.aws_internet_gateway_tags_name
  destination_cidr_block       = var.destination_cidr_block
  cidr_block                  = var.cidr_block
  enable_dns_support          = var.enable_dns_support
  enable_dns_hostnames        = var.enable_dns_hostnames

  vpc_tags_name               = var.vpc_tags_name
  public_a_tags_name          = var.public_a_tags_name
  public_b_tags_name          = var.public_b_tags_name
  private_a_tags_name         = var.private_a_tags_name
  private_b_tags_name         = var.private_b_tags_name
  map_public_ip_on_launch     = var.map_public_ip_on_launch
  route_table_public_tags_name   = var.route_table_public_tags_name
  route_table_private_tags_name  = var.route_table_private_tags_name
}

