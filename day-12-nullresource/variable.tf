variable "region" {
  default = "ap-south-1"
}

variable "db_username" {
  description = "DB Username"
  default     = "admin"
}

variable "db_password" {
  description = "DB Password"
  default     = "MySecurePass123"
}

variable "key_name" {
  description = "SSH Key Name for EC2 instance"
  default     = "Mumbai"
}

variable "private_key_path" {
  description = "Path to the SSH private key"
  type        = string
}


variable "ec2_ami" {
  description = "AMI for EC2 instance"
  default     = "ami-0f1dcc636b69a6438" # Amazon Linux 2
}
