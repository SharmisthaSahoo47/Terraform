variable "ami_id" {
  description = "ami of the instance"
  type = string
  default = "ami-002f6e91abff6eb96"

}

variable "instance_type" {
    description = "type of the instance"
    type = string
    default = "t2.micro"
  
}