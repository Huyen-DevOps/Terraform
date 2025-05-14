variable "vpc_id" {}

variable "private_subnets" {}

variable "ec2_security_group_id" {}

variable "engine" {}

variable "engine_version" {}

variable "db_name" {}

variable "db_username" {}

variable "db_password" {}

variable "parameter_group_name" {}

variable "instance_class" {}

variable "allocated_storage" {}

variable "name_prefix" {}

variable "rds_ingress_from_port" {}

variable "rds_ingress_to_port" {}

variable "rds_ingress_protocol" {}

variable "rds_egress_from_port" {}

variable "rds_egress_to_port" {}

variable "rds_egress_protocol" {}

variable "rds_egress_cidr_blocks" {}