# resource "aws_instance" "env" {
#   ami = "ami-0f1dcc636b69a6438"
#   instance_type = "t2.micro"
#    for_each = toset(var.env)
    
#    tags = {

#        Name = each.key
#    }

# }

resource "aws_instance" "env" {
    ami = "ami-0f1dcc636b69a6438"
    for_each = var.env
    instance_type = each.value

    tags = {

        Name = each.key
    }
  
}