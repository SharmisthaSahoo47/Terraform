 module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.1.0"

  identifier = "mysql-db"

  engine            = "mysql"
  engine_version    = "8.0"
  major_engine_version = "8.0"   
  family               = "mysql8.0"  
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "mydb"
  username = "admin"
  password = "ranu4748"
  port     = 3306

  publicly_accessible = false
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  db_subnet_group_name   = module.vpc.database_subnet_group

  multi_az               = false
  storage_encrypted      = true
  skip_final_snapshot    = true
  deletion_protection    = false
  backup_retention_period = 7

  tags = {
    Environment = "dev"
    Name        = "mysql-db"
  }
}
