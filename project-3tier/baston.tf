
resource "aws_instance" "baston" {
  
  ami = "ami-062f0cc54dbfd8ef1"
  instance_type = "t2.micro"
  subnet_id = module.vpc.public_subnets[0]
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  associate_public_ip_address = true

  tags = {
    Name = "baston"
  }
  
}