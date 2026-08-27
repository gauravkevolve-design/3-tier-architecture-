resource "aws_security_group" "alb" {
  name = "three-tier-alb-sg" vpc_id = var.vpc_id
  ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"] }
  egress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["0.0.0.0/0"] }
}
resource "aws_security_group" "app" {
  name = "three-tier-app-sg" vpc_id = var.vpc_id
  ingress { from_port = 80 to_port = 80 protocol = "tcp" security_groups = [aws_security_group.alb.id] }
  egress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["0.0.0.0/0"] }
}
resource "aws_security_group" "db" {
  name = "three-tier-db-sg" vpc_id = var.vpc_id
  ingress { from_port = 3306 to_port = 3306 protocol = "tcp" security_groups = [aws_security_group.app.id] }
  egress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["0.0.0.0/0"] }
}
