resource "aws_cloudwatch_log_group" "app" { name = "/three-tier/application" retention_in_days = 14 }
