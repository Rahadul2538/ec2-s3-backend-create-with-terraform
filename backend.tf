terraform {
  backend "s3" {
    bucket = "terraform-backend-practice-bucket"
    key = "terraform.tfstate"
    region  = "us-east-1"
    profile   = "<your-profile-name>"
    encrypt = true
  }
}