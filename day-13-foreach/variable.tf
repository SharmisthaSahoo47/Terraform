#variable "env" {
#  type = list(string)
#  default = [ "prod" , "test" , "dev" ]
#}

variable "env" {
    type = map(string)
    default = {
      prod = "t2.medium"
      test = "t2.targe"
      dev   = "t2.micro"
    }
  
}