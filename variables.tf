variable "aws_region" {
  description = "The AWS region to deploy the VPC."
  type        = string
  default     = "us-west-2"
}

variable "access_key" {
  description = "AWS access key"
  type        = string
  default     = ""
}

variable "secret_key" {
  description = "AWS secret key"
  type        = string
  default     = ""
}

variable "public_subnets" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "aws_internet_gateway_tags_name" {
  description = "The name tag for the Internet Gateway."
  type        = string
  default     = "Internet Gateway"
}

variable "destination_cidr_block" {
  description = "The destination CIDR block for the route."
  type        = string
  default     = "0.0.0.0/0"
}

variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_dns_support" {
  description = "Whether to enable DNS support in the VPC."
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Whether to enable DNS hostnames in the VPC."
  type        = bool
  default     = true
}

variable "vpc_tags_name" {
  description = "The name tag for the VPC."
  type        = string
  default     = "custom-vpc"
}

variable "public_a_tags_name" {
  description = "The name tag for the public subnet in availability zone A."
  type        = string
  default     = "Public Subnet A"
}

variable "public_b_tags_name" {
  description = "The name tag for the public subnet in availability zone B."
  type        = string
  default     = "Public Subnet B"
}

variable "private_a_tags_name" {
  description = "The name tag for the private subnet in availability zone A."
  type        = string
  default     = "Private Subnet A"
}

variable "private_b_tags_name" {
  description = "The name tag for the private subnet in availability zone B."
  type        = string
  default     = "Private Subnet B"
}

variable "map_public_ip_on_launch" {
  description = "Whether to map public IP on launch for the public subnet."
  type        = bool
  default     = true
}

variable "route_table_public_tags_name" {
  description = "The name tag for the public route table."
  type        = string
  default     = "Public Route Table"
}

variable "route_table_private_tags_name" {
  description = "The name tag for the private route table."
  type        = string
  default     = "Private Route Table"
}

variable "alb_name" {
  description = "Name of the ALB"
  type        = string
  default     = "mini-alb"
}

variable "internal" {
  description = "Whether the ALB is internal or internet-facing"
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "Type of the load balancer (application or network)"
  type        = string
  default     = "application"
}

variable "enable_deletion_protection" {
  description = "Enable deletion protection for the ALB"
  type        = bool
  default     = false
}

variable "listener_port" {
  description = "Port for the ALB listener"
  type        = number
  default     = 80
}

variable "listener_protocol" {
  description = "Protocol for the ALB listener"
  type        = string
  default     = "HTTP"
}

variable "default_action_type" {
  description = "Type of the default action for the ALB listener"
  type        = string
  default     = "forward"
}

variable "target_group_port" {
  description = "Port for the target group"
  type        = number
  default     = 80
}

variable "target_group_protocol" {
  description = "Protocol for the target group"
  type        = string
  default     = "HTTP"
}

variable "target_type" {
  description = "Type of the target group (instance, ip, or lambda)"
  type        = string
  default     = "instance"
}

variable "alb_sg_listener_from_port" {
  description = "Starting port for the ALB security group listener"
  type        = number
  default     = 80
}

variable "alb_sg_listener_to_port" {
  description = "Ending port for the ALB security group listener"
  type        = number
  default     = 80
}

variable "alb_sg_listener_protocol" {
  description = "Protocol for the ALB security group listener"
  type        = string
  default     = "tcp"
}

variable "alb_sg_listener_cidr_blocks" {
  description = "CIDR blocks for the ALB security group listener"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "alb_sg_listener_from_port_2" {
  description = "Starting port for the ALB security group listener (second rule)"
  type        = number
  default     = 443
}

variable "alb_sg_listener_to_port_2" {
  description = "Ending port for the ALB security group listener (second rule)"
  type        = number
  default     = 443
}

variable "alb_sg_listener_protocol_2" {
  description = "Protocol for the ALB security group listener (second rule)"
  type        = string
  default     = "tcp"
}

variable "alb_sg_listener_cidr_blocks_2" {
  description = "CIDR blocks for the ALB security group listener (second rule)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "alb_sg_egress_from_port" {
  description = "Starting port for the ALB security group egress"
  type        = number
  default     = 0
}

variable "alb_sg_egress_to_port" {
  description = "Ending port for the ALB security group egress"
  type        = number
  default     = 0
}

variable "alb_sg_egress_protocol" {
  description = "Protocol for the ALB security group egress"
  type        = string
  default     = "-1"
}

variable "alb_sg_egress_cidr_blocks" {
  description = "CIDR blocks for the ALB security group egress"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
  default     = "mini-project"
}

variable "ec2_sg_listener_from_port" {
  description = "Starting port for the EC2 security group listener"
  type        = number
  default     = 80
}

variable "ec2_sg_listener_to_port" {
  description = "Ending port for the EC2 security group listener"
  type        = number
  default     = 80
}

variable "ec2_sg_listener_protocol" {
  description = "Protocol for the EC2 security group listener"
  type        = string
  default     = "tcp"
}

variable "ec2_sg_egress_from_port" {
  description = "Starting port for the EC2 security group egress"
  type        = number
  default     = 0
}

variable "ec2_sg_egress_to_port" {
  description = "Ending port for the EC2 security group egress"
  type        = number
  default     = 0
}

variable "ec2_sg_egress_protocol" {
  description = "Protocol for the EC2 security group egress"
  type        = string
  default     = "-1"
}

variable "ec2_sg_egress_cidr_blocks" {
  description = "CIDR blocks for the EC2 security group listener"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-075686beab831bb7f"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "desired_capacity" {
  description = "Desired capacity for the Auto Scaling group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum size for the Auto Scaling group"
  type        = number
  default     = 5
}

variable "min_size" {
  description = "Minimum size for the Auto Scaling group"
  type        = number
  default     = 2
}

variable "propagate_at_launch" {
  description = "Whether to propagate the tag at launch"
  type        = bool
  default     = true
}

variable "ec2_sg_md_listener_from_port" {
  description = "Starting port for the EC2 security group listener"
  type        = number
  default     = 80
}

variable "ec2_sg_md_listener_to_port" {
  description = "Ending port for the EC2 security group listener"
  type        = number
  default     = 80
}

variable "ec2_sg_md_listener_protocol" {
  description = "Protocol for the EC2 security group listener"
  type        = string
  default     = "tcp"
}

variable "ec2_sg_md_egress_from_port" {
  description = "Starting port for the EC2 security group egress"
  type        = number
  default     = 0
}

variable "ec2_sg_md_egress_to_port" {
  description = "Ending port for the EC2 security group egress"
  type        = number
  default     = 0
}

variable "ec2_sg_md_egress_protocol" {
  description = "Protocol for the EC2 security group egress"
  type        = string
  default     = "-1"
}

variable "ec2_sg_md_egress_cidr_blocks" {
  description = "CIDR blocks for the EC2 security group egress"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "nat_instance_ami" {
  description = "AMI ID for the NAT instance"
  type        = string
  default     = "ami-075686beab831bb7f"
}

variable "key_name" {
  description = "Name of the key pair to use for the NAT instance"
  type        = string
  default     = "nat-keypair"
}