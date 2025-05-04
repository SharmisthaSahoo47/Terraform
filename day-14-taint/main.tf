resource "aws_instance" "baston" {
  
  ami = "ami-062f0cc54dbfd8ef1"
  instance_type = "t2.micro"
  key_name = "Mumbai"

  associate_public_ip_address = true

  tags = {
    Name = "baston"
  }
  
}

resource "aws_s3_bucket" "name" {
  
  bucket =  "corpitinternal"
}
  
