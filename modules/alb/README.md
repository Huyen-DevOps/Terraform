# Steps to Complete Task 3: ALB Module

## Module Goal
- Deploy an Application Load Balancer (ALB) to:
  - Balance HTTP/HTTPS traffic for applications running on multiple EC2 instances.
  - Protect with Security Groups.
  - Route to a target group containing EC2 instances.

This document explains how to implement the Application Load Balancer (ALB) module in the project.

## 1. Create the `alb` Module Directory
- Ensure the directory structure:
  ```
  modules/
    └── alb/
        ├── main.tf
        ├── variables.tf
        ├── outputs.tf
        └── README.md
  ```

## 2. Define the ALB in `main.tf`
- Use the `aws_lb` resource to create the ALB.
- Specify the public subnets for deployment.
- Enable HTTP listeners using the `aws_lb_listener` resource.
- Forward traffic to a target group using the `aws_lb_target_group` resource.
- Configure health checks for the target group.

### Example:
```hcl
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
```

## 3. Configure Security Groups
- Create a security group for the ALB to allow HTTP/HTTPS traffic from the internet.
- Create a security group for EC2 instances to allow traffic from the ALB.

### Example:
```hcl
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
  name        = "${var.name_prefix}-ec2-sg-alb"
  description = "Allow traffic from ALB to EC2 (ALB module)"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.ec2_sg_listener_from_port
    to_port         = var.ec2_sg_listener_to_port
    protocol        = var.ec2_sg_listener_protocol
    security_groups = [aws_security_group.alb_sg.id]
    description     = "Allow HTTP from ALB (ALB module)"
  }

  egress {
    from_port   = var.ec2_sg_egress_from_port
    to_port     = var.ec2_sg_egress_to_port
    protocol    = var.ec2_sg_egress_protocol
    cidr_blocks = var.ec2_sg_egress_cidr_blocks
    description = "Allow all outbound traffic (ALB module)"
  }

  tags = {
    Name = "${var.name_prefix}-ec2-sg-alb"
  }
}
```

## 4. Define Variables in `variables.tf`
- Define variables for all configurable parameters, including ALB, security groups, and target group settings.

### Example:
```hcl
variable "alb_name" {}
variable "public_subnets" {}
variable "vpc_id" {}
variable "internal" {}
variable "load_balancer_type" {}
variable "enable_deletion_protection" {}
variable "listener_port" {}
variable "listener_protocol" {}
variable "default_action_type" {}
variable "target_group_port" {}
variable "target_group_protocol" {}
variable "target_type" {}
variable "alb_sg_listener_from_port" {}
variable "alb_sg_listener_to_port" {}
variable "alb_sg_listener_protocol" {}
variable "alb_sg_listener_cidr_blocks" {}
variable "alb_sg_listener_from_port_2" {}
variable "alb_sg_listener_to_port_2" {}
variable "alb_sg_listener_protocol_2" {}
variable "alb_sg_listener_cidr_blocks_2" {}
variable "alb_sg_egress_from_port" {}
variable "alb_sg_egress_to_port" {}
variable "alb_sg_egress_protocol" {}
variable "alb_sg_egress_cidr_blocks" {}
variable "name_prefix" {}
variable "ec2_sg_listener_from_port" {}
variable "ec2_sg_listener_to_port" {}
variable "ec2_sg_listener_protocol" {}
variable "ec2_sg_egress_from_port" {}
variable "ec2_sg_egress_to_port" {}
variable "ec2_sg_egress_protocol" {}
variable "ec2_sg_egress_cidr_blocks" {}
```

## 5. Define Outputs in `outputs.tf`
- Output the ALB DNS name, ARN, security group IDs, and target group ARNs.

### Example:
```hcl
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
```

## 6. Test the Module
- Add the ALB module to the `main.tf` file in the root directory.
- Pass the required variables to the module.
- Run `terraform init`, `terraform plan`, and `terraform apply` to deploy the ALB.

### Example:
```hcl
module "alb" {
  source                  = "./modules/alb"
  alb_name                = var.alb_name
  public_subnets          = module.vpc.public_subnets
  vpc_id                  = module.vpc.vpc_id
  internal                = var.internal
  load_balancer_type      = var.load_balancer_type
  enable_deletion_protection = var.enable_deletion_protection
  listener_port           = var.listener_port
  listener_protocol       = var.listener_protocol
  default_action_type     = var.default_action_type
  target_group_port       = var.target_group_port
  target_group_protocol   = var.target_group_protocol
  target_type             = var.target_type
  alb_sg_listener_from_port = var.alb_sg_listener_from_port
  alb_sg_listener_to_port   = var.alb_sg_listener_to_port
  alb_sg_listener_protocol  = var.alb_sg_listener_protocol
  alb_sg_listener_cidr_blocks = var.alb_sg_listener_cidr_blocks
  alb_sg_listener_from_port_2 = var.alb_sg_listener_from_port_2
  alb_sg_listener_to_port_2   = var.alb_sg_listener_to_port_2
  alb_sg_listener_protocol_2  = var.alb_sg_listener_protocol_2
  alb_sg_listener_cidr_blocks_2 = var.alb_sg_listener_cidr_blocks_2
  alb_sg_egress_from_port     = var.alb_sg_egress_from_port
  alb_sg_egress_to_port       = var.alb_sg_egress_to_port
  alb_sg_egress_protocol      = var.alb_sg_egress_protocol
  alb_sg_egress_cidr_blocks   = var.alb_sg_egress_cidr_blocks
  name_prefix                 = var.name_prefix
  ec2_sg_listener_from_port   = var.ec2_sg_listener_from_port
  ec2_sg_listener_to_port     = var.ec2_sg_listener_to_port
  ec2_sg_listener_protocol    = var.ec2_sg_listener_protocol
  ec2_sg_egress_from_port     = var.ec2_sg_egress_from_port
  ec2_sg_egress_to_port       = var.ec2_sg_egress_to_port
  ec2_sg_egress_protocol      = var.ec2_sg_egress_protocol
  ec2_sg_egress_cidr_blocks   = var.ec2_sg_egress_cidr_blocks
}
```

## 7. Verify the ALB
- Access the ALB DNS name in a browser to verify it forwards traffic to the EC2 instances.
- Ensure the ALB is properly distributing traffic across the target instances.

## 8. Cleanup
- If testing is complete, run `terraform destroy` to remove the ALB and related resources.
