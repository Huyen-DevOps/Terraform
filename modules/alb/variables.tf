variable "alb_name" {}

variable "public_subnets" {}

variable "vpc_id" {}

variable "internal" {}

variable "load_balancer_type" {}

variable "enable_deletion_protection" {}

variable "listener_port" {}

variable "listener_protocol" {}

variable "default_action_type" {}

variable "target_group_port" {}

variable "target_group_protocol" {}

variable "target_type" {}

variable "alb_sg_listener_from_port" {}

variable "alb_sg_listener_to_port" {}

variable "alb_sg_listener_protocol" {}

variable "alb_sg_listener_cidr_blocks" {}

variable "alb_sg_listener_from_port_2" {}

variable "alb_sg_listener_to_port_2" {}

variable "alb_sg_listener_protocol_2" {}

variable "alb_sg_listener_cidr_blocks_2" {}

variable "alb_sg_egress_from_port" {}

variable "alb_sg_egress_to_port" {}

variable "alb_sg_egress_protocol" {}

variable "alb_sg_egress_cidr_blocks" {}

variable "name_prefix" {}

variable "ec2_sg_listener_from_port" {}

variable "ec2_sg_listener_to_port" {}

variable "ec2_sg_listener_protocol" {}

variable "ec2_sg_egress_from_port" {}

variable "ec2_sg_egress_to_port" {}

variable "ec2_sg_egress_protocol" {}

variable "ec2_sg_egress_cidr_blocks" {}