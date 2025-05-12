# Steps to Complete Task 3: ALB Module

# Mục tiêu của Module này
- Triển khai một Application Load Balancer (ALB) để:
- Cân bằng tải HTTP/HTTPS cho các ứng dụng chạy trên nhiều EC2.
- Bảo vệ bằng Security Group.
- Định tuyến đến target group chứa EC2 instances.

This document explains how to implement the Application Load Balancer (ALB) module in the project.

## 1. Create the `alb` Module Directory
- Navigate to the `modules` directory.
- Create a new folder named `alb`.

## 2. Define the ALB in `main.tf`
- Create a `main.tf` file in the `modules/alb` directory.
- Define the ALB resource:
  - Use the `aws_lb` resource to create the ALB.
  - Specify the subnets (public subnets) where the ALB will be deployed.
  - Enable HTTP listeners using the `aws_lb_listener` resource.
  - Forward traffic to a target group using the `aws_lb_target_group` resource.

```hcl
resource "aws_lb" "example" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.public_subnets

  enable_deletion_protection = false
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.example.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }
}

resource "aws_lb_target_group" "example" {
  name        = "${var.alb_name}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
}
```

## 3. Configure Security Groups
- Create a security group for the ALB to allow HTTP/HTTPS traffic from the internet.
- Ensure the security group allows traffic to the target group (EC2 instances).

```hcl
resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "Allow HTTP and HTTPS traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

## 4. Define Variables in `variables.tf`
- Create a `variables.tf` file in the `modules/alb` directory.
- Define variables for:
  - ALB name
  - Public subnets
  - Security group IDs
  - Target group details

```hcl
variable "alb_name" {
  description = "Name of the ALB"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnets for the ALB"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security group IDs for the ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID where the ALB will be deployed"
  type        = string
}
```

## 5. Define Outputs in `outputs.tf`
- Create an `outputs.tf` file in the `modules/alb` directory.
- Define outputs for:
  - ALB DNS name
  - ALB ARN

```hcl
output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.example.dns_name
}

output "alb_arn" {
  description = "ARN of the ALB"
  value       = aws_lb.example.arn
}
```

## 6. Test the Module
- Add the ALB module to the `main.tf` file in the root directory.
- Pass the required variables to the module.
- Run `terraform init`, `terraform plan`, and `terraform apply` to deploy the ALB.

```hcl
module "alb" {
  source            = "./modules/alb"
  alb_name          = "example-alb"
  public_subnets    = module.vpc.public_subnets
  security_group_ids = [module.vpc.alb_security_group_id]
  vpc_id            = module.vpc.vpc_id
}
```

## 7. Verify the ALB
- Access the ALB DNS name in a browser to verify it forwards traffic to the EC2 instances.
- Ensure the ALB is properly distributing traffic across the target instances.

## 8. Cleanup
- If testing is complete, run `terraform destroy` to remove the ALB and related resources.

