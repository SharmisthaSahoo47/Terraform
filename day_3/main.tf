resource "aws_instance" "public_server" {
    ami = var.ami_id
    instance_type = var.instance_type
    tags = {
      Name = "server"
    }
  
}
resource "aws_s3_bucket" "name" {
    
  bucket = "sharmistha47"
  tags = {
    Name = "sharmistha47"
  }
}