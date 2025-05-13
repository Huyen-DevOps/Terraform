# resource "aws_db_subnet_group" "default" {
#   name       = "${var.name_prefix}-db-subnet-group"
#   subnet_ids = var.private_subnets
#
#   tags = {
#     Name = "${var.name_prefix}-db-subnet-group"
#   }
# }
#
# resource "aws_security_group" "rds_sg" {
#   name        = "${var.name_prefix}-rds-sg"
#   description = "Allow MySQL access from EC2 instances"
#   vpc_id      = var.vpc_id
#
#   ingress {
#     from_port       = 3306
#     to_port         = 3306
#     protocol        = "tcp"
#     security_groups = [var.ec2_security_group_id]
#   }
#
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   tags = {
#     Name = "${var.name_prefix}-rds-sg"
#   }
# }
#
# resource "aws_db_instance" "default" {
#   identifier              = "${var.name_prefix}-mysql"
#   engine                  = "mysql"
#   instance_class          = var.instance_class
#   allocated_storage       = var.allocated_storage
#   db_name                 = var.db_name
#   username                = var.db_username
#   password                = var.db_password
#   db_subnet_group_name    = aws_db_subnet_group.default.name
#   vpc_security_group_ids  = [aws_security_group.rds_sg.id]
#   skip_final_snapshot     = true
#   publicly_accessible     = false
#
#   tags = {
#     Name = "${var.name_prefix}-mysql"
#   }
# }
#
