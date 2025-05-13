variable "name_prefix" {}

variable "ami_id" {}

variable "instance_type" {}

variable "desired_capacity" {}

variable "max_size" {}

variable "min_size" {}

variable "private_subnets" {}

variable "propagate_at_launch" {}

variable "vpc_id" {}

variable "ec2_sg_md_listener_from_port" {}

variable "ec2_sg_md_listener_to_port" {}

variable "ec2_sg_md_listener_protocol" {}

variable "alb_security_group_id" {}

variable "ec2_sg_md_egress_from_port" {}

variable "ec2_sg_md_egress_to_port" {}

variable "ec2_sg_md_egress_protocol" {}

variable "ec2_sg_md_egress_cidr_blocks" {}

variable "target_group_arns" {}

variable "aws_security_group_nat_sg" {}

variable "key_name" {}