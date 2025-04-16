resource "aws_vpc" "VPC_name" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
      Name = "cust_VPC"
    }
}
resource "aws_subnet" "name" {
  vpc_id = aws_vpc.VPC_name.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = false
  availability_zone = "ap-south-1a"
  tags = {
    Name = "private subnet"
  }
}
resource "aws_instance" "name" {
    ami = var.ami_id
    instance_type = var.instance_type

    tags = {
        Name = "private server"
    }
}