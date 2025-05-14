resource "aws_db_subnet_group" "default" {
  name       = "${var.name_prefix}-db-subnet-group"
  subnet_ids = var.private_subnets

  tags = {
    Name = "${var.name_prefix}-db-subnet-group"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.name_prefix}-rds-sg"
  description = "Allow MySQL access from EC2 instances"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.rds_ingress_from_port
    to_port         = var.rds_ingress_to_port
    protocol        = var.rds_ingress_protocol
    security_groups = [var.ec2_security_group_id]
  }

  egress {
    from_port   = var.rds_egress_from_port
    to_port     = var.rds_egress_to_port
    protocol    = var.rds_egress_protocol
    cidr_blocks = var.rds_egress_cidr_blocks
  }

  tags = {
    Name = "${var.name_prefix}-rds-sg"
  }
}

resource "aws_db_instance" "default" {
  identifier              = "${var.name_prefix}-mysql"
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  parameter_group_name    = var.parameter_group_name
  db_subnet_group_name    = aws_db_subnet_group.default.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  skip_final_snapshot     = true
  publicly_accessible     = false

  tags = {
    Name = "${var.name_prefix}-mysql"
  }
}

