terraform {
  backend "s3" {
    bucket = "backendstate4"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
