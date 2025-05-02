 module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.5.2"
  major_engine_version = var.major_engine_version
  family = var.family

  identifier = "mysql-db"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  username = var.db_username     # Temporarily using variable for credentials
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.rds.name
  vpc_security_group_ids = [aws_security_group.server_sg.id]
  publicly_accessible    = false

  multi_az               = false
  storage_encrypted      = true
  skip_final_snapshot    = true
  apply_immediately      = true

  tags = {
    Name = "mysql-db"
  }
}

resource "aws_db_subnet_group" "rds" {
  name       = "rds-subnet-group"
  subnet_ids = [
    module.vpc.private_subnets[2],
    module.vpc.private_subnets[3]
  ]

  tags = {
    Name = "rds-subnet-group"
  }
}
