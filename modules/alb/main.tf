resource "aws_lb" "this" { name = "three-tier-alb" internal = false load_balancer_type = "application" security_groups = [var.security_group_id] subnets = var.subnet_ids }
resource "aws_lb_target_group" "app" { name = "three-tier-app-tg" port = 80 protocol = "HTTP" vpc_id = var.vpc_id health_check { path = "/" matcher = "200-399" } }
resource "aws_lb_listener" "http" { load_balancer_arn = aws_lb.this.arn port = 80 protocol = "HTTP" default_action { type = "forward" target_group_arn = aws_lb_target_group.app.arn } }
resource "aws_lb_listener_rule" "app" { listener_arn = aws_lb_listener.http.arn priority = 100 action { type = "forward" target_group_arn = aws_lb_target_group.app.arn } condition { path_pattern { values = ["/*"] } } }
