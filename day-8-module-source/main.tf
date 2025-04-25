resource "aws_instance" "dev" {
  ami               = var.ami_id
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
}
