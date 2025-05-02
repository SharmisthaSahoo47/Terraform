 resource "aws_db_subnet_group" "rds" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.private[2].id, aws_subnet.private[3].id]

  tags = {
    Name = "rds-subnet-group"
  }
}

resource "aws_db_instance" "mysql" {
  identifier              = "mysql-db"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.rds.name
  vpc_security_group_ids  = [aws_security_group.server_sg.id]
  publicly_accessible     = false
  multi_az                = false
  storage_encrypted       = true
  skip_final_snapshot     = true
  apply_immediately       = true

  tags = {
    Name = "mysql-db"
  }
}
