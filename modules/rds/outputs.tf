output "rds_address" {
  description = "RDS address"
  value       = aws_db_instance.default.address
}

output "rds_instance_id" {
  description = "RDS instance identifier"
  value       = aws_db_instance.default.id
}