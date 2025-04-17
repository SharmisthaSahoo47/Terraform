output "public_ip" {
    value = aws_instance.public_server.public_ip
  
}
output "Private_ip" {
    value = aws_instance.public_server.private_ip
    sensitive = true
  
}