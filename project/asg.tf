# Launch Templates
resource "aws_launch_template" "frontend_lt" {
  name_prefix   = "frontend-"
  image_id      = "ami-0a0edbceaf9742962"
  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.frontend_sg.id]

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

  vpc_security_group_ids = [aws_security_group.backend_sg.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "backend-instance"
    }
  }
}

# Auto Scaling Groups
resource "aws_autoscaling_group" "frontend_asg" {
  name                      = "frontend-asg"
  max_size                  = 2
  min_size                  = 1
  desired_capacity          = 1
  vpc_zone_identifier       = [module.vpc.private_subnets[4], module.vpc.private_subnets[5]]
  launch_template {
    id      = aws_launch_template.frontend_lt.id
    version = "$Latest"
  }

  target_group_arns = [module.frontend_alb.target_group_arns[0]]

  tag {
    key                 = "Name"
    value               = "frontend-asg-instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "backend_asg" {
  name                      = "backend-asg"
  max_size                  = 2
  min_size                  = 1
  desired_capacity          = 1
  vpc_zone_identifier       = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]
  launch_template {
    id      = aws_launch_template.backend_lt.id
    version = "$Latest"
  }

  target_group_arns = [module.backend_alb.target_group_arns[0]]

  tag {
    key                 = "Name"
    value               = "backend-asg-instance"
    propagate_at_launch = true
  }
}

# Security Groups
resource "aws_security_group" "frontend_sg" {
  name        = "frontend-sg"
  description = "Allow HTTP and HTTPS traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "backend_sg" {
  name        = "backend-sg"
  description = "Allow HTTP traffic from frontend"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
 