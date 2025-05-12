output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.load_balancer.dns_name
}

output "alb_arn" {
  description = "ARN of the ALB"
  value       = aws_lb.load_balancer.arn
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}