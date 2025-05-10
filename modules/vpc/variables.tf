variable "cidr_block" {}
variable "enable_dns_support" {}
variable "enable_dns_hostnames" {}
variable "map_public_ip_on_launch" {}
variable "aws_region" {}

variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }

variable "vpc_tags_name" {}
variable "public_a_tags_name" {}
variable "public_b_tags_name" {}
variable "private_a_tags_name" {}
variable "private_b_tags_name" {}
variable "aws_internet_gateway_tags_name" {}
variable "route_table_public_tags_name" {}
variable "route_table_private_tags_name" {}
variable "destination_cidr_block" {}