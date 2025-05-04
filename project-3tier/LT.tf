 resource "aws_launch_template" "frontend_lt" {
  name_prefix   = "frontend-"
  image_id      = "ami-0620734a55d9b066c"
  instance_type = "t3.micro"
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_launch_template" "backend_lt" {
  name_prefix   = "backend-"
  image_id      = "ami-06939db9842e35e36"
  instance_type = "t3.micro"
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  lifecycle {
    prevent_destroy = true
  }
}
