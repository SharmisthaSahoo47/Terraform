module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = "Cust_vpc"
  cidr = "10.0.0.0/16"

  azs = ["ap-south-1a", "ap-south-1b"]

  public_subnets = [
    "10.0.1.0/24",  # ap-south-1a
    "10.0.2.0/24"   # ap-south-1b
  ]

  private_subnets = [
    "10.0.3.0/24",  # ap-south-1a (frontend)
    "10.0.4.0/24",  # ap-south-1b (frontend)
    "10.0.5.0/24",  # ap-south-1a (backend)
    "10.0.6.0/24",  # ap-south-1b (backend)
    
  ]

  enable_nat_gateway     = false
  single_nat_gateway     = false
  enable_dns_hostnames   = true
  enable_dns_support     = true
  create_igw             = true
  create_database_subnet_group = true
  database_subnets       = ["10.0.7.0/24", "10.0.8.0/24"]

  manage_default_route_table   = false 

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
 

