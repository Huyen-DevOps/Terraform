
# Tasks to Complete the 3-Tier Infrastructure Project

## 1. Project Setup
- [ ] Create the project directory structure as outlined:
  ```bash
  terraform-3tier-project/
  ├── main.tf
  ├── variables.tf
  ├── outputs.tf
  ├── modules/
  │   ├── vpc/
  │   ├── ec2/
  │   ├── alb/
  │   └── rds/
  ├── terraform.tfvars
  ```

## 2. VPC Module
- [ ] Create a `modules/vpc` directory.
- [ ] Implement a custom VPC with:
  - [ ] A CIDR block for the VPC.
  - [ ] DNS support and DNS hostnames enabled.
  - [ ] 2 Availability Zones.
  - [ ] 2 public subnets and 2 private subnets.
  - [ ] An Internet Gateway for public subnets.
  - [ ] Route tables for public and private subnets.
  - [ ] Proper route table associations.
  - [ ] NAT instance for private subnets.

## 3. ALB Module
- [ ] Create a `modules/alb` directory.
- [ ] Deploy an Application Load Balancer (ALB) in public subnets.
- [ ] Configure ALB to forward traffic to EC2 instances.
- [ ] Configure health checks for the target group.
- [ ] Create and attach Security Groups for ALB and EC2.

## 4. EC2 Module
- [ ] Create a `modules/ec2` directory.
- [ ] Deploy 2 EC2 instances in private subnets using a Launch Template and Auto Scaling Group.
- [ ] Use Amazon Linux AMI and install a web server (nginx).
- [ ] Ensure EC2 Security Group allows traffic from ALB Security Group.

## 5. RDS Module
- [ ] Create a `modules/rds` directory.
- [ ] Deploy an RDS MySQL database in private subnets.
- [ ] Ensure only EC2 instances can access the database (via Security Group).

## 6. Variables
- [ ] Define variables in `variables.tf` for:
  - [ ] AMI ID.
  - [ ] AWS region.
  - [ ] Instance type.
  - [ ] Database password.
  - [ ] Other configurable parameters.

## 7. Outputs
- [ ] Define outputs in `outputs.tf` for:
  - [ ] ALB DNS name.
  - [ ] RDS endpoint.
  - [ ] Other relevant information.

## 8. Terraform Configuration
- [ ] Write the main Terraform configuration in `main.tf` to:
  - [ ] Call the VPC, ALB, EC2, and RDS modules.
  - [ ] Pass variables and outputs between modules.

## 9. Testing and Validation
- [ ] Run `terraform init`, `terraform plan`, and `terraform apply` to deploy the infrastructure.
- [ ] Verify:
  - [ ] ALB is accessible via its DNS name.
  - [ ] EC2 instances are running and serving web traffic.
  - [ ] RDS is accessible only from EC2 instances.

## 10. Documentation
- [ ] Document the project setup and usage in a `README.md` file.
- [ ] Provide code examples and module usage in each module's `README.md`.

