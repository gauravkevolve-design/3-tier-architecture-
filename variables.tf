variable "aws_region" { type = string default = "ap-south-1" }
variable "vpc_cidr" { type = string default = "10.0.0.0/16" }
variable "public_subnet_1_cidr" { type = string default = "10.0.1.0/24" }
variable "public_subnet_2_cidr" { type = string default = "10.0.2.0/24" }
variable "private_subnet_1_cidr" { type = string default = "10.0.11.0/24" }
variable "private_subnet_2_cidr" { type = string default = "10.0.12.0/24" }
variable "db_subnet_1_cidr" { type = string default = "10.0.21.0/24" }
variable "db_subnet_2_cidr" { type = string default = "10.0.22.0/24" }
variable "ami_id" { type = string }
variable "instance_type" { type = string default = "t3.micro" }
variable "key_name" { type = string }
variable "docker_image" { type = string default = "public.ecr.aws/docker/library/nginx:alpine" }
variable "db_name" { type = string default = "appdb" }
variable "db_username" { type = string default = "appadmin" }
variable "db_password" { type = string sensitive = true }
