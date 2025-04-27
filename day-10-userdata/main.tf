 resource "aws_instance" "server" {
  ami = "ami-0f1dcc636b69a6438"
  instance_type = "t2.micro"

  tags = {
    Name = "ec2instance"
  }

 user_data_base64 = filebase64("test.sh")

}