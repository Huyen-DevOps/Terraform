output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.load_balancer.dns_name
}

output "alb_arn" {
  description = "ARN of the ALB"
  value       = aws_lb.load_balancer.arn
}

output "alb_security_group_id" {
  description = "Security group ID of the ALB"
  value       = aws_security_group.alb_sg.id
}

output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}

output "target_group_arns" {
  description = "ARNs of the target groups"
  value       = [aws_lb_target_group.target_group.arn]
}
