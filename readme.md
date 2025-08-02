# Terraform Lab: EC2 + S3 + Remote Backend 

This project demonstrates how to use Terraform to:

- Launch an EC2 instance
- Create an S3 bucket
- Configure Terraform remote state in S3
- Use variables and outputs for flexibility


---

## ✅ Step 1: Define Input Variables (`variables.tf`)

This file declares three input variables: AWS region, instance type, and AMI ID. Defaults are also provided.

```hcl
variable "region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami" {
  type    = string
  default = "ami-0c55b159cbfafe1f0"  # Free Tier Ubuntu AMI
}
What This Does:
Declares input variables for region, instance type, and AMI.
Provides default values, which can be overridden.

✅ Step 2: Provide Actual Values (terraform.tfvars)
This file overrides the default values of the variables and provides real values for deployment.

hcl
Copy
Edit
region         = "us-east-1"
instance_type  = "t3.micro"
ami            = "ami-0c55b159cbfafe1f0"
What This Does:
Overrides values from variables.tf.

Provides the actual region, AMI, and instance type to be used.

✅ Step 3: Define AWS Resources (main.tf)
This file contains the actual AWS resource definitions.

hcl
Copy
Edit
provider "aws" {
  region = var.region
}

resource "aws_instance" "my_ec2" {
  instance_type = var.instance_type
  ami           = var.ami

  tags = {
    Name = "Terraform-EC2-Instance-Lab"
  }
}

resource "aws_s3_bucket" "tf_bucket" {
  bucket = "terraform-backend-practice-bucket"
}
What This Does:
Configures the AWS provider with the given region.

Launches an EC2 instance using variable values.

Creates an S3 bucket for remote state or custom use.

✅ Step 4: Output Key Information (outputs.tf)
This file is used to display key information after the infrastructure is applied.

hcl
Copy
Edit
output "instance_public_ip" {
  value = aws_instance.my_ec2.public_ip
}

output "bucket_name" {
  value = aws_s3_bucket.tf_bucket.bucket
}
What This Does:
Prints the public IP of the EC2 instance.

Prints the S3 bucket name after deployment.

✅ Step 5: Configure Remote Backend (backend.tf)
This file configures Terraform to store its state file in the S3 bucket and optionally use DynamoDB for state locking.

hcl
Copy
Edit
terraform {
  backend "s3" {
    bucket         = "terraform-backend-practice-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    profile        = "aws-profile-name"
    encrypt        = true
  }
}
What This Does:
Stores the Terraform state remotely in the specified S3 bucket.

Encrypts the state file.

Uses an AWS profile from your local AWS CLI config.

Can be extended to support state locking with DynamoDB.

✅ How to Run the Project
bash
Copy
Edit
# Initialize Terraform and configure the backend
terraform init

# Show execution plan
terraform plan

# Apply changes to create infrastructure
terraform apply
✅ Destroy the Infrastructure
bash
Copy
Edit
terraform destroy

