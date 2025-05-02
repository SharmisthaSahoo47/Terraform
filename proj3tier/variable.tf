 variable "region" {
  default = "ap-south-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "azs" {
  default = ["ap-south-1a", "ap-south-1b"]
}

variable "public_subnet_cidrs" {
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_subnet_cidrs" {
  default = [
    "10.0.2.0/24",  # private1
    "10.0.3.0/24",  # private2
    "10.0.4.0/24",  # rdspvt1
    "10.0.5.0/24",  # rdspvt2
    "10.0.6.0/24",  # frontend1
    "10.0.10.0/24"  # frontend2
  ]
}

variable "project_tags" {
  default = {
    Project = "3-tier-architecture"
  }
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  default = "ranu4748"
}
