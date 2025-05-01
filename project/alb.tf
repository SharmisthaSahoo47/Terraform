#Frontend ALB and target group
module "frontend_alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.4.0"

  name               = "frontend-alb"
  load_balancer_type = "application"
  internal           = false
  vpc_id             = module.vpc.vpc_id
  subnets            = [module.vpc.private_subnets[4], module.vpc.private_subnets[5]]

  security_groups = [aws_security_group.alb_sg.id]

  target_groups = [
    {
      name_prefix      = "fe-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = [
        {
          id   = aws_instance.frontend1.id
          port = 80
        },
        
      ]
    }
  ]

  listeners = [
    {
      port     = 80
      protocol = "HTTP"
      default_action = {
        type             = "forward"
        target_group_index = 0
      }
    }
  ]

  tags = var.project_tags
}

#Backend ALB 
module "backend_alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.4.0"

  name               = "backend-alb"
  load_balancer_type = "application"
  internal           = true
  vpc_id             = module.vpc.vpc_id
  subnets            = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]

  security_groups = [aws_security_group.alb_sg.id]

  target_groups = [
    {
      name_prefix      = "be-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = [
        {
          id   = aws_instance.backend1.id
          port = 80
        },
        
      ]
    }
  ]

  listeners = [
    {
      port     = 80
      protocol = "HTTP"
      default_action = {
        type             = "forward"
        target_group_index = 0
      }
    }
  ]

  tags = var.project_tags
}
## Frontend and Backend Instances
resource "aws_instance" "frontend1" {
  ami           = "ami-0a0edbceaf9742962"
  instance_type = "t3.micro"
  subnet_id     = module.vpc.private_subnets[4]
  vpc_security_group_ids = [aws_security_group.server_sg.id]

  tags = {
    Name = "frontend1"
  }
}

resource "aws_instance" "backend1" {
  ami           = "ami-0b72b0395736d0307"
  instance_type = "t3.micro"
  subnet_id     = module.vpc.private_subnets[0]
  vpc_security_group_ids = [aws_security_group.server_sg.id]

  tags = {
    Name = "backend1"
  }
}
#ALB security group
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Allow HTTP from internet or internal"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # public access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg"
  }
}


