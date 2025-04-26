module "prod" {

    source = "github.com/SharmisthaSahoo47/Terraform/day-8-module-source"
    ami_id = "ami-002f6e91abff6eb96"
    instance_type = "t2.micro"
    availability_zone = "ap-south-1c"

}