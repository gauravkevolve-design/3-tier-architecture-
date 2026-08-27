resource "aws_launch_template" "app" {
  name_prefix = "three-tier-app-"
  image_id = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [var.security_group_id]
  user_data = base64encode(<<-EOF
#!/bin/bash
apt-get update -y
apt-get install -y docker.io
systemctl enable --now docker
docker pull ${var.docker_image}
docker run -d --restart unless-stopped -p 80:80 --name app ${var.docker_image}
EOF
  )
  tag_specifications { resource_type = "instance" tags = { Name = "three-tier-app" } }
}
resource "aws_autoscaling_group" "app" {
  name = "three-tier-app-asg" desired_capacity = 2 min_size = 2 max_size = 4
  vpc_zone_identifier = var.subnet_ids
  target_group_arns = [var.target_group_arn]
  health_check_type = "ELB"
  launch_template { id = aws_launch_template.app.id version = "$Latest" }
}
resource "aws_autoscaling_policy" "cpu" {
  name = "three-tier-cpu-scaling" autoscaling_group_name = aws_autoscaling_group.app.name policy_type = "TargetTrackingScaling"
  target_tracking_configuration { predefined_metric_specification { predefined_metric_type = "ASGAverageCPUUtilization" } target_value = 50 }
}
