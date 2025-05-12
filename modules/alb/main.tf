resource "aws_lb" "load_balancer" {
  name               = var.alb_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.public_subnets

  enable_deletion_protection = var.enable_deletion_protection
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = var.default_action_type
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_lb_target_group" "target_group" {
  name        = "${var.alb_name}-tg"
  port        = var.target_group_port
  protocol    = var.target_group_protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "Allow HTTP and HTTPS traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.alb_sg_listener_from_port
    to_port     = var.alb_sg_listener_to_port
    protocol    = var.alb_sg_listener_protocol
    cidr_blocks = var.alb_sg_listener_cidr_blocks
  }

  ingress {
    from_port   = var.alb_sg_listener_from_port_2
    to_port     = var.alb_sg_listener_to_port_2
    protocol    = var.alb_sg_listener_protocol_2
    cidr_blocks = var.alb_sg_listener_cidr_blocks_2
  }

  egress {
    from_port   = var.alb_sg_egress_from_port
    to_port     = var.alb_sg_egress_to_port
    protocol    = var.alb_sg_egress_protocol
    cidr_blocks = var.alb_sg_egress_cidr_blocks
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "${var.name_prefix}-ec2-sg"
  description = "Allow traffic from ALB to EC2"
  vpc_id      = var.vpc_id

  ingress {
    from_port                = var.ec2_sg_listener_from_port
    to_port                  = var.ec2_sg_listener_to_port
    protocol                 = var.ec2_sg_listener_protocol
    security_groups          = [aws_security_group.alb_sg.id]
    description              = "Allow HTTP from ALB"
  }

  egress {
    from_port   = var.ec2_sg_egress_from_port
    to_port     = var.ec2_sg_egress_to_port
    protocol    = var.ec2_sg_egress_protocol
    cidr_blocks = var.ec2_sg_egress_cidr_blocks
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "${var.name_prefix}-ec2-sg"
  }
}

