output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.web.name
}

output "launch_template_id" {
  description = "ID of the Launch Template"
  value       = aws_launch_template.web.id
}

output "ec2_sg_id" {
  description = "ID of the EC2 Security Group"
  value       = aws_security_group.ec2_sg_md.id
}