# Mini Project: Deploying a 3-Tier Infrastructure on AWS Using Terraform

## Objective
Deploy a web system consisting of:
- A dedicated VPC
- 2 public subnets and 2 private subnets
- ALB (Application Load Balancer) in public subnets
- 2 EC2 web servers in private subnets (optionally behind an Auto Scaling Group)
- 1 RDS (MySQL) in private subnet
- Properly configured Security Groups
- Use of outputs and variable modules

---

## Suggested Project Structure
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

---

## What You'll Implement

| **Component**     | **Description**                                                                                                            |
|-------------------|----------------------------------------------------------------------------------------------------------------------------|
| **VPC**           | Create a custom VPC, 2 Availability Zones, 4 subnets, route tables, 1 Public instance using Amazon Linux AMI               |
| **ALB**           | Public-facing Load Balancer forwarding traffic to EC2 instances                                                            |
| **EC2**           | 2 instances using Ubuntu AMI, running a web server (nginx) in private subnets, optionally managed by an Auto Scaling Group |
| **RDS**           | MySQL DB in private subnet, secured so only EC2 instances can access it                                                    |
| **Modules**       | Split configurations into `modules/vpc`, `modules/ec2`, etc.                                                               |
| **Variables**     | Use variables for AMI, region, instance_type, DB password, etc.                                                            |
| **Outputs**       | Output ALB DNS name, RDS endpoint, etc.                                                                                    |
| **Security**      | Security Groups for ALB, EC2, and RDS, with correct ingress/egress rules                                                   |
| **Testing**       | Validate infrastructure by accessing ALB and verifying connectivity                                                        |
| **Documentation** | Provide clear documentation and usage instructions                                                                         |

---

## Skills You’ll Learn

- Organizing Terraform projects using modules
- Deploying multi-tier architecture
- AWS networking: VPC, subnets, route tables
- Integrating services: ALB → EC2 → RDS
- Writing reusable infrastructure code
- Using variables and outputs for modularity
- Applying security best practices with Security Groups
- Testing and validating AWS infrastructure

