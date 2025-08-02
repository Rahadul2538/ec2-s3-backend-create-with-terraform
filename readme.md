# Terraform Lab: EC2 + S3 + Remote Backend

This project demonstrates how to use **Terraform** to provision an **EC2 instance**, create an **S3 bucket**, and configure **remote state storage** using **S3 

---

## 🎯 Lab Objectives

- ✅ Launch an EC2 instance
- ✅ Create an S3 bucket for remote state
- ✅ Configure Terraform to store its state in the S3 bucket
- ✅ Use `variables` and `outputs`


---

## 📁 Directory Structure

terraform-lab/
├── main.tf # AWS resources (EC2 + S3)
├── variables.tf # Input variables
├── terraform.tfvars # Actual variable values
├── outputs.tf # Output values
├── backend.tf # Backend (S3 + DynamoDB) configuration



---

## 🧩 Prerequisites

- AWS CLI configured with a profile  
- Terraform installed  
- An AWS IAM user with EC2, S3, and DynamoDB access  
- A DynamoDB table for state locking

---


### ✅ Step 1: Define Input Variables (`variables.tf`)

This file declares three input variables: AWS region, instance type, and AMI ID. Defaults are also provided.

```hcl
variable "region" {
  type = string
  default = "us-east-1"
}
variable "instance_type" {
  type = string
  default = "t2.micro"
}
variable "ami" {
  type = string
  default = "ami-0c55b159cbfafe1f0" # Free Tier Ubuntu AMI
}

✅ Step 2: Provide Actual Values (terraform.tfvars)
This file overrides the default values of the variables and provides real values for deployment.

region         = "us-east-1"
instance_type  = "t3.micro"
ami            = "ami-0c55b159cbfafe1f0"


✅ Step 3: Define AWS Resources (main.tf)
This file contains the actual AWS resource definitions.


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

What This Does:
AWS provider is configured using the selected region.

An EC2 instance is created using the AMI and instance type from variables.

An S3 bucket is created for storing Terraform state or any custom usage.

✅ Step 4: Output Key Information (outputs.tf)
This file is used to display key information after the infrastructure is applied.

output "instance_public_ip" {
  value = aws_instance.my_ec2.public_ip
}
output "bucket_name" {
  value = aws_s3_bucket.tf_bucket.bucket
}

What This Does:
Prints the EC2 instance's public IP.

Prints the name of the S3 bucket.

✅ Step 5: Configure Remote Backend (backend.tf)
This file configures Terraform to store its state file in the S3 bucket and optionally use DynamoDB for state locking.

terraform {
  backend "s3" {
    bucket = "terraform-backend-practice-bucket"
    key = "terraform.tfstate"
    region  = "us-east-1"
    profile   = "<your-profile-name>"
    encrypt = true
  }
}

What This Does:
Stores Terraform state file remotely in the specified S3 bucket.

Encrypts the state file.

Uses a specific AWS CLI profile.

The "key" acts like the file name in the bucket.


⚙️ How to Use

# Step 1: Initialize Terraform (downloads provider, configures backend)
terraform init

# Step 2: Preview the infrastructure changes
terraform plan

# Step 3: Apply the configuration and create resources
terraform apply

🧹 Clean Up
To destroy all resources created by Terraform:
terraform destroy


