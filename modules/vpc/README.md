# Steps to Complete Task 2: VPC Module

This document explains how to implement the VPC module with 2 Availability Zones, 2 public subnets, 2 private subnets, an Internet Gateway, a NAT instance, and proper route table associations.

## 1. Create the `vpc` Module Directory
Ensure the directory structure is as follows:
```bash
modules/
└── vpc/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
```

## 2. Define the VPC in `main.tf`
- Create a custom VPC with a CIDR block (e.g., `10.0.0.0/16`).
- Use the `aws_vpc` resource to define the VPC.

### Example:
```hcl
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = var.vpc_tags_name
  }
}
```

## 3. Create Subnets
- Define 2 public subnets and 2 private subnets in different availability zones.
- Use the `aws_subnet` resource for each subnet.

### Example:
```hcl
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnets[0]
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = var.public_a_tags_name
  }
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets[0]
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = var.private_a_tags_name
  }
}
```

## 4. Create an Internet Gateway and Route for Public Subnets
- Use `aws_internet_gateway` to create an Internet Gateway.
- Use `aws_route` to add a route for `0.0.0.0/0` in the public route table.

### Example:
```hcl
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.aws_internet_gateway_tags_name
  }
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = var.destination_cidr_block
  gateway_id             = aws_internet_gateway.igw.id
}
```

## 5. Create Route Tables and Associations
- Use `aws_route_table` to create route tables for public and private subnets.
- Use `aws_route_table_association` to associate subnets with the appropriate route tables.

### Example:
```hcl
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.route_table_public_tags_name
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}
```

### Note:
The Main Route Table is always applied if no specific route table is assigned to a subnet. 
However, if you create other route tables (such as public or private) and assign them to a subnet, 
that subnet will use the assigned route table instead of the Main Route Table. 
Currently, the code includes 3 route tables: main, public, and private.

## 6. Create a NAT Instance and Security Group
- Use `aws_instance` to create a NAT instance in a public subnet.
- Use `aws_security_group` to allow outbound traffic and allow ingress from private subnets.

### Example:
```hcl
resource "aws_instance" "nat_instance" {
  ami                         = var.nat_instance_ami
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_a.id
  associate_public_ip_address = true
  source_dest_check           = false
  key_name                    = var.key_name

  vpc_security_group_ids = [aws_security_group.nat_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
              sysctl -p

              yum update -y
              yum install -y iptables-services

              iptables -t nat -A POSTROUTING -o eth0 -s ${var.private_subnets[0]} -j MASQUERADE
              iptables -t nat -A POSTROUTING -o eth0 -s ${var.private_subnets[1]} -j MASQUERADE

              service iptables save
              systemctl enable iptables
              systemctl start iptables
              EOF

  tags = {
    Name = "${var.name_prefix}-nat-instance"
  }
}

resource "aws_security_group" "nat_sg" {
  name        = "${var.name_prefix}-nat-sg"
  description = "Allow outbound traffic (VPC module)"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = [var.private_subnets[0], var.private_subnets[1]]
  }
}
```

## 7. Add NAT Route for Private Subnets
- Use `aws_route` to add a route in the private route table for `0.0.0.0/0` via the NAT instance.

### Example:
```hcl
resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = var.destination_cidr_block
  network_interface_id   = aws_instance.nat_instance.primary_network_interface_id

  depends_on = [aws_instance.nat_instance]
}
```

## 8. Define Variables in `variables.tf`
- Define variables for the AWS region, CIDR blocks, NAT AMI, key name, and other configurable parameters.

### Example:
```hcl
variable "aws_region" {}
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "destination_cidr_block" {}
variable "nat_instance_ami" {}
variable "key_name" {}
```

## 9. Define Outputs in `outputs.tf`
- Output the VPC ID, subnet IDs, route table IDs, Internet Gateway ID, and NAT security group for use in other modules.

### Example:
```hcl
output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}

output "private_subnet_ids" {
  value = [aws_subnet.private_a.id, aws_subnet.private_b.id]
}

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

output "aws_security_group_nat_sg" {
  value = aws_security_group.nat_sg.id
}
```

## 10. Test the Module
- Run `terraform init`, `terraform plan`, and `terraform apply` to validate the configuration.
- Verify that the VPC, subnets, Internet Gateway, NAT instance, and route tables are created as expected.

```bash
terraform init
terraform plan
terraform apply
```

## 11. Integrate with the Main Configuration
- Call this module from the `main.tf` file in the root directory.
- Pass the required variables (e.g., `aws_region`, `public_subnets`, `private_subnets`, `nat_instance_ami`, `key_name`).

### Example:
```hcl
module "vpc" {
  source              = "./modules/vpc"
  aws_region          = var.aws_region
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
  cidr_block          = var.cidr_block
  enable_dns_support  = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  vpc_tags_name       = var.vpc_tags_name
  public_a_tags_name  = var.public_a_tags_name
  public_b_tags_name  = var.public_b_tags_name
  private_a_tags_name = var.private_a_tags_name
  private_b_tags_name = var.private_b_tags_name
  aws_internet_gateway_tags_name = var.aws_internet_gateway_tags_name
  route_table_public_tags_name   = var.route_table_public_tags_name
  route_table_private_tags_name  = var.route_table_private_tags_name
  destination_cidr_block         = var.destination_cidr_block
  nat_instance_ami               = var.nat_instance_ami
  key_name                       = var.key_name
  name_prefix                    = var.name_prefix
  map_public_ip_on_launch        = var.map_public_ip_on_launch
}
```
