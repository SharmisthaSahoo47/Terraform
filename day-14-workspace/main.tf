 provider "aws" {
  region = "ap-south-1"
}

resource "aws_iam_user" "example" {
  name = "example-user-${terraform.workspace}"

  tags = {
    Environment = terraform.workspace
  }
}

output "user_name" {
  value = aws_iam_user.example.name
}
##############
# terraform workspace
#Usage: terraform [global options] workspace

 # new, list, show, select and delete Terraform workspaces.

#Subcommands:
#    delete    Delete a workspace
#    list      List Workspaces
#    new       Create a new workspace
#    select    Select a workspace
#    show      Show the name of the current workspace