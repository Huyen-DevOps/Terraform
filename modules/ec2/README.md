# Steps to Complete Task 4: EC2 Module

This document explains how to implement the EC2 module in the project.

## 1. Create the `ec2` Module Directory
- Navigate to the `modules` directory.
- Create a new folder named `ec2`.

## 2. Define the EC2 Launch Template in `main.tf`
- Create a `main.tf` file in the `modules/ec2` directory.
- Define the EC2 launch template:
  - Use the `aws_launch_template` resource to define the EC2 configuration.
  - Specify the AMI ID, instance type, and security group.
  - Use a Launch Template and an Auto Scaling Group to launch multiple EC2 instances running Amazon Linux 2 with NGINX.

### Example Code:
```hcl
resource "aws_launch_template" "web" {
  name_prefix   = "${var.name_prefix}-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras enable nginx1
              sudo yum install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              echo "Hello from EC2 instance" > /usr/share/nginx/html/index.html
              EOF
  )
}

resource "aws_autoscaling_group" "web" {
  desired_capacity     = 2
  max_size             = 5
  min_size             = 2
  vpc_zone_identifier  = var.private_subnets
  launch_template {
    id      = aws_launch_template.web.id
    version = aws_launch_template.web.latest_version
  }

  tag {
    key                 = "Name"
    value               = "${var.name_prefix}-asg"
    propagate_at_launch = true
  }
}
```

## 3. Configure Security Groups
- Create a security group for the EC2 instances to allow traffic from the ALB or other sources.

### Example Code:
```hcl
resource "aws_security_group" "ec2_sg" {
  name        = "${var.name_prefix}-ec2-sg"
  description = "Allow traffic from ALB to EC2"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-ec2-sg"
  }
}
```

## 4. Define Variables in `variables.tf`
- Create a `variables.tf` file in the `modules/ec2` directory.
- Define variables for:
  - AMI ID
  - Instance type
  - Subnets
  - VPC ID
  - Security group IDs

### Example Code:
```hcl
variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
  default     = "t2.micro"
}

variable "private_subnets" {
  description = "List of private subnets for EC2 instances"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID where the EC2 instances will be deployed"
  type        = string
}

variable "alb_security_group_id" {
  description = "Security group ID of the ALB"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
}
```

## 5. Define Outputs in `outputs.tf`
- Create an `outputs.tf` file in the `modules/ec2` directory.
- Define outputs for:
  - Auto Scaling Group name
  - Launch Template ID

### Example Code:
```hcl
output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.web.name
}

output "launch_template_id" {
  description = "ID of the Launch Template"
  value       = aws_launch_template.web.id
}
```

## 6. Test the Module
- Add the EC2 module to the `main.tf` file in the root directory.
- Pass the required variables to the module.
- Run `terraform init`, `terraform plan`, and `terraform apply` to deploy the EC2 instances.

### Example Code in Root `main.tf`:
```hcl
module "ec2" {
  source             = "./modules/ec2"
  ami_id             = "ami-0c02fb55956c7d316" # Replace with a valid Amazon Linux 2 AMI ID
  instance_type      = var.instance_type
  private_subnets    = module.vpc.private_subnets
  vpc_id             = module.vpc.vpc_id
  alb_security_group_id = module.alb.alb_security_group_id
  name_prefix        = var.name_prefix
}
```

## 7. Verify the EC2 Instances
- Check the AWS Console for running EC2 instances in the Auto Scaling Group.
- Verify that the web server is running and serving the expected content.

## 8. Cleanup
- If testing is complete, run `terraform destroy` to remove the EC2 instances and related resources.

