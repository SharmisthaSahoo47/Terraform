 resource "aws_launch_template" "frontend_lt" {
  name_prefix   = "frontend-"
  image_id      = "ami-0a0edbceaf9742962"
  instance_type = "t3.micro"
  key_name      = "Mumbai"  # Mumbai.pem

  vpc_security_group_ids = [aws_security_group.server_sg.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "frontend-instance"
    }
  }
}

resource "aws_launch_template" "backend_lt" {
  name_prefix   = "backend-"
  image_id      = "ami-0b72b0395736d0307"
  instance_type = "t3.micro"
  key_name      = "Mumbai"

  vpc_security_group_ids = [aws_security_group.server_sg.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "backend-instance"
    }
  }
}

resource "aws_autoscaling_group" "frontend_asg" {
  name                = "frontend-asg"
  max_size            = 2
  min_size            = 1
  desired_capacity    = 1
  vpc_zone_identifier = [aws_subnet.private[4].id, aws_subnet.private[5].id]

  launch_template {
    id      = aws_launch_template.frontend_lt.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.frontend_tg.arn]

  tag {
    key                 = "Name"
    value               = "frontend-asg-instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "backend_asg" {
  name                = "backend-asg"
  max_size            = 2
  min_size            = 1
  desired_capacity    = 1
  vpc_zone_identifier = [aws_subnet.private[0].id, aws_subnet.private[1].id]

  launch_template {
    id      = aws_launch_template.backend_lt.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.backend_tg.arn]

  tag {
    key                 = "Name"
    value               = "backend-asg-instance"
    propagate_at_launch = true
  }
}
