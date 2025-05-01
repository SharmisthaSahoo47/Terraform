 #variables for VPC and subnets
 variable "region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = [
    "10.0.2.0/24",  # private1
    "10.0.3.0/24",  # private2
    "10.0.4.0/24",  # rdspvt1
    "10.0.5.0/24",  # rdspvt2
    "10.0.6.0/24",  # frontend1
    "10.0.10.0/24"  # frontend2
  ]
}

variable "project_tags" {
  description = "Map of tags to assign to resources"
  type        = map(string)
  default = {
    Project = "3-tier-architecture"
  }
}

#RDS variables
variable "db_username" {
  description = "Master username for the RDS instance"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Master password for the RDS instance"
  type        = string
  default     = "ranu@4748"
}
