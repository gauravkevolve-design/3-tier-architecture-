resource "aws_db_subnet_group" "this" { name = "three-tier-db-subnets" subnet_ids = var.subnet_ids }
resource "aws_db_instance" "mysql" {
  identifier = var.identifier
  engine = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"
  allocated_storage = 20
  db_name = var.db_name
  username = var.username
  password = var.password
  db_subnet_group_name = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.security_group_id]
  publicly_accessible = false
  multi_az = true
  backup_retention_period = 7
  skip_final_snapshot = true
}
