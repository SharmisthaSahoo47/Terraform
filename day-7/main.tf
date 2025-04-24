#vpc
resource "aws_vpc" "custVPC" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}
#subnet
resource "aws_subnet" "sub1" {
  vpc_id = aws_vpc.custVPC.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
}

resource "aws_subnet" "sub2" {
  vpc_id = aws_vpc.custVPC.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1b"
}
#IG
resource "aws_internet_gateway" "IGW" {
  
  vpc_id = aws_vpc.custVPC.id
}

#RT
resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.custVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
}

#RT association
resource "aws_route_table_association" "RT1" {
  
  subnet_id = aws_subnet.sub1.id
  route_table_id = aws_route_table.RT.id
}
resource "aws_route_table_association" "RT2" {
  
  subnet_id = aws_subnet.sub2.id
  route_table_id = aws_route_table.RT.id
}
#SG for rds 
resource "aws_security_group" "rds_replica_sg" {
  name        = "rds-replica-sg"
  description = "Allow access to read replica"
  vpc_id      = aws_vpc.custVPC.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Adjust this for your setup
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



#subnetgroup in default VPC used for primary db
resource "aws_db_subnet_group" "sub-grp-primary" {
  name = "primary-sub-grp"
  subnet_ids = [ "subnet-053dbd71f3c82e5d4", "subnet-0f75c2d55f57da0a9" ]
}
#subnet group in cust VPC used for secondary read replica
resource "aws_db_subnet_group" "sub-grp-secondary" {
  name = "secondary-sub-grp"
  subnet_ids = [ aws_subnet.sub1.id, aws_subnet.sub2.id ]
}
#IAM role for RDS
resource "aws_iam_role" "rds_monitoring" {
  name = "rds-monitoring-role"
  provider = aws
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "monitoring.rds.amazonaws.com"
      }
    }]
  })
}
#The role already exist on my end so importing it.
#terraform import aws_iam_role.rds_monitoring rds-monitoring-role

#attach IAM Role
resource "aws_iam_role_policy_attachment" "rds_monitoring_attach" {
  
  role       = aws_iam_role.rds_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

#RDS
resource "aws_db_instance" "default" {
  allocated_storage       = 10
   identifier =             "book-rds"
  db_name                 = "mydb"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = "admin"
  password                = "Cloud123"
  db_subnet_group_name    = aws_db_subnet_group.sub-grp-primary.name
  parameter_group_name    = "default.mysql8.0"
  provider = aws

  # Enable backups and retention
  backup_retention_period  = 7   # Retain backups for 7 days
  backup_window            = "02:00-03:00" # Daily backup window (UTC)

  # Enable monitoring (CloudWatch Enhanced Monitoring)
  monitoring_interval      = 60  # Collect metrics every 60 seconds
  monitoring_role_arn      = aws_iam_role.rds_monitoring.arn

  # Enable performance insights
#   performance_insights_enabled          = true
#   performance_insights_retention_period = 7  # Retain insights for 7 days

  # Maintenance window
  maintenance_window = "sun:04:00-sun:05:00"  # Maintenance every Sunday (UTC)

  # Enable deletion protection (to prevent accidental deletion)
  deletion_protection = true
  # Skip final snapshot
  skip_final_snapshot = true
}
#RDS read replica
resource "aws_db_instance" "read_replica" {
  identifier            = "book-rds-replica"
  replicate_source_db   = aws_db_instance.default.arn
  instance_class        = "db.t3.micro"
  db_subnet_group_name  = aws_db_subnet_group.sub-grp-secondary.name
  publicly_accessible   = true
  vpc_security_group_ids = [aws_security_group.rds_replica_sg.id] 
  depends_on = [aws_db_instance.default]
}
