module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  public_subnet_1_cidr = var.public_subnet_1_cidr
  public_subnet_2_cidr = var.public_subnet_2_cidr
  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr
  db_subnet_1_cidr = var.db_subnet_1_cidr
  db_subnet_2_cidr = var.db_subnet_2_cidr
}

module "security_groups" {
  source = "./modules/security-groups"
  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source = "./modules/alb"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnet_ids
  security_group_id = module.security_groups.alb_sg_id
  target_security_group_id = module.security_groups.app_sg_id
}

module "asg" {
  source = "./modules/asg"
  ami_id = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_ids = module.vpc.private_subnet_ids
  security_group_id = module.security_groups.app_sg_id
  target_group_arn = module.alb.target_group_arn
  docker_image = var.docker_image
}

module "rds" {
  source = "./modules/rds"
  identifier = "three-tier-mysql"
  subnet_ids = module.vpc.db_subnet_ids
  vpc_id = module.vpc.vpc_id
  security_group_id = module.security_groups.db_sg_id
  db_name = var.db_name
  username = var.db_username
  password = var.db_password
}
