# VPC
resource "aws_vpc" "custvpc" {
cidr_block = "10.0.0.0/16"
  
}
#subnet
resource "aws_subnet" "sub1" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.custvpc.id
}
resource "aws_subnet" "sub2" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.custvpc.id
}
#IG attached to vpc
resource "aws_internet_gateway" "IG" {
vpc_id = aws_vpc.custvpc.id
}
#RT
resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.custvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IG.id
  }

  tags = {
    Name = "public-rt"
  }
}

#RT association
resource "aws_route_table_association" "RT" {
  subnet_id = aws_subnet.sub1.id
  route_table_id = aws_route_table.RT.id
}
#create elastic ip
resource "aws_eip" "name" {
  domain = "vpc"
}
#natgateway
resource "aws_nat_gateway" "NAT" {
    allocation_id = aws_eip.name.id
    subnet_id = aws_subnet.sub1.id
    depends_on = [ aws_internet_gateway.IG ]
}

#natgateway association to private subnet
resource "aws_route_table" "pvtRT" {
  vpc_id = aws_vpc.custvpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT.id 
  }

  tags = {
    Name = "private-rt"
  }
}

#association with private subnet
resource "aws_route_table_association" "pvtRT" {
  subnet_id = aws_subnet.sub2.id
  route_table_id = aws_route_table.pvtRT.id
}
#SG
resource "aws_security_group" "ssh_sg" {
  name        = "ssh-allow"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.custvpc.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow TCP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh-security-group"
  }
}

#instance
resource "aws_instance" "name" {
  ami = "ami-002f6e91abff6eb96"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.sub2.id
  associate_public_ip_address = false
  tags = {
    name = "server"
  }
}