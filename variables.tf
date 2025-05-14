variable "aws_region" {
  description = "The AWS region to deploy the VPC."
  type        = string
}

variable "public_subnets" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "aws_internet_gateway_tags_name" {
  description = "The name tag for the Internet Gateway."
  type        = string
}

variable "destination_cidr_block" {
  description = "The destination CIDR block for the route."
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "enable_dns_support" {
  description = "Whether to enable DNS support in the VPC."
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "Whether to enable DNS hostnames in the VPC."
  type        = bool
}

variable "vpc_tags_name" {
  description = "The name tag for the VPC."
  type        = string
}

variable "public_a_tags_name" {
  description = "The name tag for the public subnet in availability zone A."
  type        = string
}

variable "public_b_tags_name" {
  description = "The name tag for the public subnet in availability zone B."
  type        = string
}

variable "private_a_tags_name" {
  description = "The name tag for the private subnet in availability zone A."
  type        = string
}

variable "private_b_tags_name" {
  description = "The name tag for the private subnet in availability zone B."
  type        = string
}

variable "map_public_ip_on_launch" {
  description = "Whether to map public IP on launch for the public subnet."
  type        = bool
}

variable "route_table_public_tags_name" {
  description = "The name tag for the public route table."
  type        = string
}

variable "route_table_private_tags_name" {
  description = "The name tag for the private route table."
  type        = string
}

variable "alb_name" {
  description = "Name of the ALB"
  type        = string
}

variable "internal" {
  description = "Whether the ALB is internal or internet-facing"
  type        = bool
}

variable "load_balancer_type" {
  description = "Type of the load balancer (application or network)"
  type        = string
}

variable "enable_deletion_protection" {
  description = "Enable deletion protection for the ALB"
  type        = bool
}

variable "listener_port" {
  description = "Port for the ALB listener"
  type        = number
}

variable "listener_protocol" {
  description = "Protocol for the ALB listener"
  type        = string
}

variable "default_action_type" {
  description = "Type of the default action for the ALB listener"
  type        = string
}

variable "target_group_port" {
  description = "Port for the target group"
  type        = number
}

variable "target_group_protocol" {
  description = "Protocol for the target group"
  type        = string
}

variable "target_type" {
  description = "Type of the target group (instance, ip, or lambda)"
  type        = string
}

variable "alb_sg_listener_from_port" {
  description = "Starting port for the ALB security group listener"
  type        = number
}

variable "alb_sg_listener_to_port" {
  description = "Ending port for the ALB security group listener"
  type        = number
}

variable "alb_sg_listener_protocol" {
  description = "Protocol for the ALB security group listener"
  type        = string
}

variable "alb_sg_listener_cidr_blocks" {
  description = "CIDR blocks for the ALB security group listener"
  type        = list(string)
}

variable "alb_sg_listener_from_port_2" {
  description = "Starting port for the ALB security group listener (second rule)"
  type        = number
}

variable "alb_sg_listener_to_port_2" {
  description = "Ending port for the ALB security group listener (second rule)"
  type        = number
}

variable "alb_sg_listener_protocol_2" {
  description = "Protocol for the ALB security group listener (second rule)"
  type        = string
}

variable "alb_sg_listener_cidr_blocks_2" {
  description = "CIDR blocks for the ALB security group listener (second rule)"
  type        = list(string)
}

variable "alb_sg_egress_from_port" {
  description = "Starting port for the ALB security group egress"
  type        = number
}

variable "alb_sg_egress_to_port" {
  description = "Ending port for the ALB security group egress"
  type        = number
}

variable "alb_sg_egress_protocol" {
  description = "Protocol for the ALB security group egress"
  type        = string
}

variable "alb_sg_egress_cidr_blocks" {
  description = "CIDR blocks for the ALB security group egress"
  type        = list(string)
}

variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
}

variable "ec2_sg_listener_from_port" {
  description = "Starting port for the EC2 security group listener"
  type        = number
}

variable "ec2_sg_listener_to_port" {
  description = "Ending port for the EC2 security group listener"
  type        = number
}

variable "ec2_sg_listener_protocol" {
  description = "Protocol for the EC2 security group listener"
  type        = string
}

variable "ec2_sg_egress_from_port" {
  description = "Starting port for the EC2 security group egress"
  type        = number
}

variable "ec2_sg_egress_to_port" {
  description = "Ending port for the EC2 security group egress"
  type        = number
}

variable "ec2_sg_egress_protocol" {
  description = "Protocol for the EC2 security group egress"
  type        = string
}

variable "ec2_sg_egress_cidr_blocks" {
  description = "CIDR blocks for the EC2 security group listener"
  type        = list(string)
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
}

variable "desired_capacity" {
  description = "Desired capacity for the Auto Scaling group"
  type        = number
}

variable "max_size" {
  description = "Maximum size for the Auto Scaling group"
  type        = number
}

variable "min_size" {
  description = "Minimum size for the Auto Scaling group"
  type        = number
}

variable "propagate_at_launch" {
  description = "Whether to propagate the tag at launch"
  type        = bool
}

variable "ec2_sg_md_listener_from_port" {
  description = "Starting port for the EC2 security group listener"
  type        = number
}

variable "ec2_sg_md_listener_to_port" {
  description = "Ending port for the EC2 security group listener"
  type        = number
}

variable "ec2_sg_md_listener_protocol" {
  description = "Protocol for the EC2 security group listener"
  type        = string
}

variable "ec2_sg_md_egress_from_port" {
  description = "Starting port for the EC2 security group egress"
  type        = number
}

variable "ec2_sg_md_egress_to_port" {
  description = "Ending port for the EC2 security group egress"
  type        = number
}

variable "ec2_sg_md_egress_protocol" {
  description = "Protocol for the EC2 security group egress"
  type        = string
}

variable "ec2_sg_md_egress_cidr_blocks" {
  description = "CIDR blocks for the EC2 security group egress"
  type        = list(string)
}

variable "nat_instance_ami" {
  description = "AMI ID for the NAT instance"
  type        = string
}

variable "key_name" {
  description = "Name of the key pair to use for the NAT instance"
  type        = string
}

variable "engine" {
  description = "Database engine to use"
  type        = string
}

variable "engine_version" {
  description = "Database engine version to use"
  type        = string
}

variable "db_name" {
  description = "Name of the database"
  type        = string
}

variable "db_username" {
  description = "Username for the database"
  type        = string
}

variable "db_password" {
  description = "Password for the database"
  type        = string
}

variable "parameter_group_name" {
  description = "Parameter group name for the RDS instance"
  type        = string
}

variable "instance_class" {
  description = "Instance class for the RDS instance"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage for the RDS instance"
  type        = number
}

variable "rds_ingress_from_port" {
  description = "Starting port for the RDS security group listener"
  type        = number
}

variable "rds_ingress_to_port" {
  description = "Ending port for the RDS security group listener"
  type        = number
}

variable "rds_ingress_protocol" {
  description = "Protocol for the RDS security group listener"
  type        = string
}

variable "rds_egress_from_port" {
  description = "Starting port for the RDS security group egress"
  type        = number
}

variable "rds_egress_to_port" {
  description = "Ending port for the RDS security group egress"
  type        = number
}

variable "rds_egress_protocol" {
  description = "Protocol for the RDS security group egress"
  type        = string
}

variable "rds_egress_cidr_blocks" {
  description = "CIDR blocks for the RDS security group egress"
  type        = list(string)
}
