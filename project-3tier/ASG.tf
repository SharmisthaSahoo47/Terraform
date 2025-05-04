 
# FRONTEND ASG MODULE
module "frontend_asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "7.4.0"

  name = "frontend-asg"

  vpc_zone_identifier = [
    module.vpc.private_subnets[0],
    module.vpc.private_subnets[1]
  ]

  desired_capacity          = 1
  max_size                  = 2
  min_size                  = 1
  health_check_type         = "EC2"
  wait_for_capacity_timeout = "0"

  create_launch_template    = false
  
  launch_template_id      = aws_launch_template.frontend_lt.id
  launch_template_version = aws_launch_template.frontend_lt.latest_version


  target_group_arns = [
    aws_lb_target_group.frontend_tg.arn
  ]

  tags = {
    Name = "frontend"
  }
  depends_on = [aws_launch_template.frontend_lt]

}

# BACKEND ASG MODULE
module "backend_asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "7.4.0"

  name = "backend-asg"

  vpc_zone_identifier = [
    module.vpc.private_subnets[2],
    module.vpc.private_subnets[3]
  ]

  desired_capacity          = 1
  max_size                  = 2
  min_size                  = 1
  health_check_type         = "EC2"
  wait_for_capacity_timeout = "0"

  create_launch_template    = false
  launch_template_id      = aws_launch_template.backend_lt.id
  launch_template_version = aws_launch_template.backend_lt.latest_version


  target_group_arns = [
    aws_lb_target_group.backend_tg.arn
  ]

  tags = {
    Name = "backend"
  }
  depends_on = [aws_launch_template.backend_lt]

}
