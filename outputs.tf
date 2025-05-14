# VPC module
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "route_table_public_id" {
  value = module.vpc.route_table_public_id
}

output "route_table_public_association_ids" {
  value = module.vpc.route_table_public_association_ids
}

output "route_table_private_id" {
  value = module.vpc.route_table_private_id
}

output "route_table_private_association_ids" {
  value = module.vpc.route_table_private_association_ids
}

output "aws_security_group_nat_sg" {
  value = module.vpc.aws_security_group_nat_sg
}

# ALB module
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "alb_arn" {
  value = module.alb.alb_arn
}

output "alb_security_group_id" {
  value = module.alb.alb_security_group_id
}

output "alb_target_group_arns" {
  value = module.alb.target_group_arns
}

output "alb_ec2_sg_id" {
  value = module.alb.ec2_sg_id
}

# EC2 module
output "ec2_asg_name" {
  value = module.ec2.asg_name
}

output "ec2_launch_template_id" {
  value = module.ec2.launch_template_id
}

output "ec2_sg_id" {
  value = module.ec2.ec2_sg_id
}

# RDS module
output "rds_address" {
  value = module.rds.rds_address
}

output "rds_instance_id" {
  value = module.rds.rds_instance_id
}
