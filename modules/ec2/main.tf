resource "aws_launch_template" "web" {
  name_prefix   = "${var.name_prefix}-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.ec2_sg_md.id]
  key_name      = var.key_name

  user_data = base64encode(<<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              echo "Hello from EC2 instance" > /var/www/html/index.html
              EOF
  )
}

resource "aws_autoscaling_group" "web" {
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  vpc_zone_identifier  = var.private_subnets
  target_group_arns    = var.target_group_arns

  launch_template {
    id      = aws_launch_template.web.id
    version = aws_launch_template.web.latest_version
  }

  tag {
    key                 = "Name"
    value               = "${var.name_prefix}-asg"
    propagate_at_launch = var.propagate_at_launch
  }
}

resource "aws_security_group" "ec2_sg_md" {
  name        = "${var.name_prefix}-ec2-sg-md"
  description = "Allow traffic from ALB to EC2 (EC2 module)"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.ec2_sg_md_listener_from_port
    to_port         = var.ec2_sg_md_listener_to_port
    protocol        = var.ec2_sg_md_listener_protocol
    security_groups = [var.alb_security_group_id]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"        # "all"
    cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [var.aws_security_group_nat_sg]
  }

  egress {
    from_port   = var.ec2_sg_md_egress_from_port
    to_port     = var.ec2_sg_md_egress_to_port
    protocol    = var.ec2_sg_md_egress_protocol
    cidr_blocks = var.ec2_sg_md_egress_cidr_blocks
  }

  tags = {
    Name = "${var.name_prefix}-ec2-sg-md"
  }
}
