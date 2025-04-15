variable "ami_id" {
  description = "Ami for instance creation"
  type = string
  default = "ami-002f6e91abff6eb96"
}
variable "instance_type" {
  description = "type of the instance to be created"
  type = string
  default = "t2.micro"
}