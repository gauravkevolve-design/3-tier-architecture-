# Highly Available 3-Tier Web Application on AWS with Terraform

Portfolio project demonstrating a production-style AWS 3-tier architecture with reusable Terraform modules, high availability, autoscaling, monitoring, IAM and remote state practices.

## Architecture

Internet → Application Load Balancer → EC2 Auto Scaling Group → Amazon RDS MySQL

- **Web tier:** Internet-facing Application Load Balancer in two public subnets
- **Application tier:** Dockerized EC2 instances in private subnets across two Availability Zones
- **Database tier:** Amazon RDS MySQL in dedicated private database subnets with Multi-AZ enabled
- **Networking:** VPC, Internet Gateway, NAT Gateway and route tables
- **Security:** Separate ALB, application and database security groups; database access is restricted to the application tier
- **Scaling:** EC2 Auto Scaling with CPU target tracking and ELB health checks
- **Monitoring:** CloudWatch log group and alarms for ASG CPU and ALB/application 5XX errors
- **IAM:** EC2 instance profile with restricted CloudWatch permissions
- **IaC:** Reusable Terraform modules
- **CI/CD:** GitHub Actions runs Terraform format and validation checks
- **State:** S3 remote-state example with encryption and Terraform state locking via S3 lockfile

## Structure

```text
.
├── .github/workflows/terraform.yml
├── modules/
│   ├── vpc/
│   ├── security-groups/
│   ├── alb/
│   ├── asg/
│   ├── iam/
│   ├── monitoring/
│   └── rds/
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── backend.tf
├── backend.tf.example
├── terraform.tfvars.example
├── .gitignore
├── LICENSE
└── ATTRIBUTION.md
```

## Deployment

1. Configure AWS credentials using the AWS CLI or your preferred credential provider.
2. Create an EC2 key pair in the selected AWS region.
3. Copy `terraform.tfvars.example` to `terraform.tfvars` and provide your AMI ID, key pair and database password.
4. If using remote state, replace the placeholder S3 bucket name in `backend.tf` with your own bucket and enable versioning/encryption on that bucket.
5. Run:

```bash
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

6. Get the ALB endpoint:

```bash
terraform output -raw alb_dns_name
```

7. Destroy the environment after testing:

```bash
terraform destroy
```

## Security and cost notes

- Never commit `terraform.tfvars`, credentials or `terraform.tfstate`.
- The database is not publicly accessible.
- Use AWS Secrets Manager or another secret-management solution for production database credentials.
- NAT Gateway, RDS and EC2 resources incur AWS charges. Destroy the lab after testing.

## Resume alignment

This repository demonstrates the technologies and architecture described in the resume project: AWS, Terraform, EC2, VPC, RDS MySQL, ALB, Auto Scaling, CloudWatch, IAM, Git and CI/CD.

## Attribution

This implementation was developed using a public MIT-licensed 3-tier Terraform project as an architectural reference. See `ATTRIBUTION.md` and `LICENSE` for details.

## Author

Gaurav Kumar
