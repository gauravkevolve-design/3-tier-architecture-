terraform {
  backend "s3" {
    bucket         = "REPLACE_WITH_YOUR_TERRAFORM_STATE_BUCKET"
    key            = "3-tier-architecture/terraform.tfstate"
    region         = "ap-south-1"
    use_lockfile   = true
    encrypt        = true
  }
}

# Do not commit real bucket names or credentials.
# Create the S3 bucket first, then run:
# terraform init -migrate-state
