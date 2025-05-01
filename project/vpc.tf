
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs = ["ap-south-1a", "ap-south-1b"]

  public_subnets = [
    "10.0.0.0/24", # public1 in 1a
    "10.0.1.0/24"  # public2 in 1b
  ]

  private_subnets = [
    "10.0.2.0/24", # private1 in 1a
    "10.0.3.0/24", # private2 in 1b
    "10.0.4.0/24", # rdspvt1 in 1a
    "10.0.5.0/24"  # rdspvt2 in 1b
  ]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  enable_dns_hostnames   = true
  enable_dns_support     = true
  map_public_ip_on_launch = true

  tags = {
    Project = "3-tier-architecture"
  }
}
#public route table
resource "aws_route_table" "public" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.vpc.igw_id
  }

  tags = {
    Name = "public-rt"
  }
}
#public routetable association
resource "aws_route_table_association" "public_subnets" {
  for_each = toset(module.vpc.public_subnets)

  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}
#private route table
resource "aws_route_table" "private" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = module.vpc.nat_gateway_ids[0]
  }

  tags = {
    Name = "private-rt"
  }
}
#private route table association
resource "aws_route_table_association" "private_subnets" {
  for_each = toset(module.vpc.private_subnets)

  subnet_id      = each.value
  route_table_id = aws_route_table.private.id
}
#Security group
resource "aws_security_group" "server_sg" {
  name        = "server-sg"
  description = "Allow SSH, HTTP, HTTPS, and MySQL"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "MySQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "server-sg"
  }
}

