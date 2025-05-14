# Steps to Complete Task 4: EC2 Module

This document explains how to implement the EC2 module in the project.

## 1. Create the `ec2` Module Directory
- Navigate to the `modules` directory.
- Create a new folder named `ec2`.

## 2. Define the EC2 Launch Template and Auto Scaling Group in `main.tf`
- Use the `aws_launch_template` resource to define the EC2 configuration.
- Use the `aws_autoscaling_group` resource to manage scaling.
- The launch template installs NGINX and MySQL client, and checks RDS connectivity.

### Example Code:
```hcl
resource "aws_launch_template" "web" {
  name_prefix   = "${var.name_prefix}-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.ec2_sg_md.id]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              echo "Hello from EC2 instance" > /var/www/html/index.html
              sudo apt-get install mysql-client -y
              echo "== START MYSQL CHECK ==" >> /var/www/html/index.html
              MYSQL_PWD='${var.db_password}' mysql -h ${var.rds_address} -u ${var.db_username} -e "SHOW DATABASES;" >> /var/www/html/index.html 2>&1
              echo "== END MYSQL CHECK ==" >> /var/www/html/index.html
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
```

## 3. Configure Security Groups
- Create a security group for the EC2 instances to allow traffic from the ALB and optionally from public subnets.

### Example Code:
```hcl
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
    protocol    = "-1"
    cidr_blocks = var.public_subnets
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
```

## 4. Define Variables in `variables.tf`
- Create a `variables.tf` file in the `modules/ec2` directory.
- Define variables for:
  - Name prefix
  - AMI ID
  - Instance type
  - Desired, min, max capacity
  - Private subnets
  - Propagate at launch
  - VPC ID
  - Security group ports/protocols
  - ALB security group ID
  - Target group ARNs
  - Public subnets
  - RDS address, DB username, DB password

### Example Code:
```hcl
variable "name_prefix" {}
variable "ami_id" {}
variable "instance_type" {}
variable "desired_capacity" {}
variable "max_size" {}
variable "min_size" {}
variable "private_subnets" {}
variable "propagate_at_launch" {}
variable "vpc_id" {}
variable "ec2_sg_md_listener_from_port" {}
variable "ec2_sg_md_listener_to_port" {}
variable "ec2_sg_md_listener_protocol" {}
variable "alb_security_group_id" {}
variable "ec2_sg_md_egress_from_port" {}
variable "ec2_sg_md_egress_to_port" {}
variable "ec2_sg_md_egress_protocol" {}
variable "ec2_sg_md_egress_cidr_blocks" {}
variable "target_group_arns" {}
variable "public_subnets" {}
variable "rds_address" {}
variable "db_username" {}
variable "db_password" {}
```

## 5. Define Outputs in `outputs.tf`
- Create an `outputs.tf` file in the `modules/ec2` directory.
- Define outputs for:
  - Auto Scaling Group name
  - Launch Template ID
  - EC2 Security Group ID

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

output "ec2_sg_id" {
  description = "ID of the EC2 Security Group"
  value       = aws_security_group.ec2_sg_md.id
}
```

## 6. Test the Module
- Add the EC2 module to the `main.tf` file in the root directory.
- Pass the required variables to the module.
- Run `terraform init`, `terraform plan`, and `terraform apply` to deploy the EC2 instances.

### Example Code in Root `main.tf`:
```hcl
module "ec2" {
  source                = "./modules/ec2"
  name_prefix           = var.name_prefix
  ami_id                = var.ami_id
  instance_type         = var.instance_type
  desired_capacity      = var.desired_capacity
  max_size              = var.max_size
  min_size              = var.min_size
  private_subnets       = module.vpc.private_subnets
  propagate_at_launch   = var.propagate_at_launch
  vpc_id                = module.vpc.vpc_id
  ec2_sg_md_listener_from_port = var.ec2_sg_md_listener_from_port
  ec2_sg_md_listener_to_port   = var.ec2_sg_md_listener_to_port
  ec2_sg_md_listener_protocol  = var.ec2_sg_md_listener_protocol
  alb_security_group_id        = module.alb.alb_security_group_id
  ec2_sg_md_egress_from_port   = var.ec2_sg_md_egress_from_port
  ec2_sg_md_egress_to_port     = var.ec2_sg_md_egress_to_port
  ec2_sg_md_egress_protocol    = var.ec2_sg_md_egress_protocol
  ec2_sg_md_egress_cidr_blocks = var.ec2_sg_md_egress_cidr_blocks
  target_group_arns            = module.alb.target_group_arns
  public_subnets               = module.vpc.public_subnets
  rds_address                  = module.rds.rds_address
  db_username                  = var.db_username
  db_password                  = var.db_password
}
```

## 7. Verify the EC2 Instances
- Check the AWS Console for running EC2 instances in the Auto Scaling Group.
- Verify that the web server is running and serving the expected content.
- The index page should show the result of the MySQL connectivity check.

## 8. Cleanup
- If testing is complete, run `terraform destroy` to remove the EC2 instances and related resources.
