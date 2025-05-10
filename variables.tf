variable "aws_region" {
  description = "The AWS region to deploy the VPC."
  type        = string
  default     = "us-west-2"
}

variable "access_key" {
  description = "AWS access key"
  type        = string
  default   = ""
}

variable "secret_key" {
  description = "AWS secret key"
  type        = string
  default   = ""
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
