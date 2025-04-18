resource "aws_vpc" "cust_vpc" {
  
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "myVPC"
  }
}

resource "aws_subnet" "dev" {
    cidr_block = "10.0.0.0/24"
   vpc_id = aws_vpc.cust_vpc.id
   tags = { Name = "dev"}
}
resource "aws_subnet" "test" {
    cidr_block = "10.0.5.0/24"
    vpc_id = aws_vpc.cust_vpc.id
    tags = { Name = "test"}
  
}
resource "aws_subnet" "prod" {
    cidr_block = "10.0.15.0/24"
    vpc_id = aws_vpc.cust_vpc.id
    tags = { Name = "prd"}
}

resource "aws_subnet" "uat" {
    cidr_block = "10.0.6.0/24"
    vpc_id = aws_vpc.cust_vpc.id
    tags = { Name = "uat"}
  
}