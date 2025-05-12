# Steps to Complete Task 2: VPC Module

This document explains how to implement the VPC module with 2 Availability Zones, 2 public subnets, 2 private subnets, an Internet Gateway, and proper route table associations.

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

## 6. Define Variables in `variables.tf`
- Define variables for the AWS region, CIDR blocks, and other configurable parameters.

### Example:
```hcl
variable "aws_region" {}

variable "public_subnets" {}

variable "private_subnets" {}

variable "destination_cidr_block" {}
```

## 7. Define Outputs in `outputs.tf`
- Output the VPC ID, subnet IDs, route table IDs, and Internet Gateway ID for use in other modules.

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
```

## 8. Test the Module
- Run `terraform init`, `terraform plan`, and `terraform apply` to validate the configuration.
- Verify that the VPC, subnets, Internet Gateway, and route tables are created as expected.

```bash
terraform init
terraform plan
terraform apply
```

## 9. Integrate with the Main Configuration
- Call this module from the `main.tf` file in the root directory.
- Pass the required variables (e.g., `aws_region`, `public_subnets`, `private_subnets`).

### Example:
```hcl
module "vpc" {
  source          = "./modules/vpc"
  aws_region      = var.aws_region
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}
```
`