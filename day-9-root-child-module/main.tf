module "my_ec2_instance" {
  source        = "./modules/ec2-instance"
  ami_id        = "ami-002f6e91abff6eb96" # example AMI
  instance_type = "t2.micro"
  name          = "test-instance"
}

module "my_s3_bucket" {
  source        = "./modules/s3"
  bucket_name   = "corp-wipros3-bucket"
  environment   = "dev"
}