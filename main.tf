provider "aws" {
  region = var.region
}
resource "aws_instance" "my_ec2" {
  instance_type = var.instance_type
  ami = var.ami

  tags = {
     Name = "Terraform-Ec2-Instance-Lab"
  }
}
  
resource "aws_s3_bucket" "tf_bucket" {
  bucket = "terraform-backend-practice-bucket"
}