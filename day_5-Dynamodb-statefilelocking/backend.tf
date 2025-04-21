terraform {
  backend "s3" {
    bucket = "backendstate4"
    key    = "day_5/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-state-lock-dynamo" # DynamoDB table used for state locking, DB created by console
    encrypt        = true  # Ensures the state is encrypted at rest in S3.
    
  }
}
