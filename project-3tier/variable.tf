 variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24", ]
}

variable "key_name" {
  description = "EC2 key pair name for SSH access"
  type        = string
  default     = "Mumbai"
}

#security group variables
variable "ingress_ports" {
  description = "List of ingress rules with port ranges and protocols"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "MySQL"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}


# Additional variables for ALB and ASG
variable "web_sg_id" {
  description = "Security group ID for ALBs"
  type        = string
}

variable "frontend_lt_id" {
  description = "Launch template ID for frontend ASG"
  type        = string
}

variable "backend_lt_id" {
  description = "Launch template ID for backend ASG"
  type        = string
}

variable "frontend_lt_version" {
  description = "Launch template version for frontend ASG"
  type        = string
  default     = "$Latest"
}

variable "backend_lt_version" {
  description = "Launch template version for backend ASG"
  type        = string
  default     = "$Latest"
}


variable "frontend_instance_type" {
  description = "EC2 instance type for frontend"
  type        = string
  default     = "t3.micro"
}

variable "backend_instance_type" {
  description = "EC2 instance type for backend"
  type        = string
  default     = "t3.micro"
}
