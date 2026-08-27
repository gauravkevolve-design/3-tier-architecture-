# AWS 3-Tier Architecture with Terraform

A portfolio-ready, highly available AWS 3-tier architecture provisioned with Terraform.

## Architecture

```text
Internet
   |
   v
+-----------------------------+
| Application Load Balancer   |  Public subnets / 2 AZs
+-----------------------------+
              |
              v
+-----------------------------+
| EC2 Auto Scaling Group      |  Private application subnets / 2 AZs
| Amazon Linux + Docker       |
+-----------------------------+
              |
              v
+-----------------------------+
| Amazon RDS MySQL            |  Private database subnets / 2 AZs
+-----------------------------+
```

## AWS components

- VPC with public, application-private and database-private subnet tiers
- Internet Gateway and NAT Gateway
- Internet-facing Application Load Balancer
- EC2 Launch Template and Auto Scaling Group across two Availability Zones
- Amazon RDS MySQL in private subnets
- Separate security groups for ALB, application and database tiers
- Terraform modules for reusable infrastructure
- CPU target-tracking autoscaling
- Terraform validation workflow through GitHub Actions

## Project structure

```text
.
├── .github/workflows/terraform.yml
├── modules/
│   ├── vpc/
│   ├── security-groups/
│   ├── alb/
│   ├── asg/
│   └── rds/
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── versions.tf
├── terraform.tfvars.example
├── .gitignore
├── LICENSE
└── ATTRIBUTION.md
```

## Prerequisites

- AWS account
- AWS CLI configured locally
- Terraform >= 1.6
- An EC2 key pair in the target AWS region

## Deploy

1. Copy the example variables file:

```bash
cp terraform.tfvars.example terraform.tfvars
```

2. Set your AWS region, EC2 key pair name and database credentials in `terraform.tfvars`.

3. Initialize and validate Terraform:

```bash
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

4. Open the ALB DNS name returned by:

```bash
terraform output -raw alb_dns_name
```

5. Destroy resources when finished to avoid AWS charges:

```bash
terraform destroy
```

## Security notes

- Application EC2 instances have no public IP addresses.
- The application security group accepts HTTP only from the ALB security group.
- The database security group accepts MySQL only from the application security group.
- Database credentials are supplied through variables and are not committed.
- `terraform.tfstate` and `terraform.tfvars` are ignored by Git.

## Attribution

This repository is a cleaned and refactored portfolio implementation based on the architecture approach and Terraform module structure of the MIT-licensed project documented in `ATTRIBUTION.md`. The original copyright notice is retained in `LICENSE`.

## Author

Gaurav Kumar — AWS / Cloud / DevOps portfolio project.
