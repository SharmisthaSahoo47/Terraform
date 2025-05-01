# resource "aws_instance" "env" {
#    ami =  "ami-0f1dcc636b69a6438"
#    instance_type = "t2.micro"
#    count = length(var.env)
#    tags = {
      
#      Name = var.env[count.index]
#    }
   
# } 

resource "aws_instance" "env" {
    ami =  "ami-0f1dcc636b69a6438"
    instance_type = "t2.micro"
    count = 5

    tags = {
      
      Name = "server-${count.index}"
    }

  
}