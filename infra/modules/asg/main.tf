data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_iam_instance_profile" "lab" {
  name = var.instance_profile_name
}

resource "aws_launch_template" "app" {
  name_prefix   = "${var.name_prefix}-lt-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  vpc_security_group_ids = [var.ec2_sg_id]

  iam_instance_profile {
    name = data.aws_iam_instance_profile.lab.name
  }

  user_data = base64encode(templatefile("${path.module}/templates/user_data.sh.tftpl", {
    secret_arn      = var.secret_arn
    aws_region      = var.aws_region
    artifact_bucket = var.artifact_bucket
    artifact_key    = var.artifact_key
  }))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.name_prefix}-ec2"
      App  = "${var.name_prefix}-vendor-booking" # 改掉 event-ticketing
    }
  }

  tags = {
    Name = "${var.name_prefix}-lt"
  }
}

resource "aws_autoscaling_group" "app" {
  name = "${var.name_prefix}-asg"

  vpc_zone_identifier       = var.private_subnet_ids
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  health_check_type         = "ELB"
  health_check_grace_period = 300
  target_group_arns         = [var.target_group_arn]

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
  }

  tag {
    key                 = "Name"
    value               = "${var.name_prefix}-asg-instance"
    propagate_at_launch = true
  }

  tag {
    key                 = "App"
    value               = "${var.name_prefix}-vendor-booking" # 改掉 event-ticketing
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "cpu_target_tracking" {
  name                   = "${var.name_prefix}-asg-cpu-scaling"
  autoscaling_group_name = aws_autoscaling_group.app.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = var.cpu_target_value
  }
}