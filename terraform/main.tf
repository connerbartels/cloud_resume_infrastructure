terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.74.0"
    }
  }

  backend "s3" {
    bucket = "terraform-state-conner-bartels"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web_server" {
  ami             = "ami-0ddc798b3f1a5117e"
  instance_type   = "t2.micro"
  count           = 2

  tags = {
    Name          = "EC2 Terraform Instance"
    ProvisionedBy = "Terraform"
    Environment   = "Prod"
    Project       = "Cloud Resume Challenge"
  }
}

resource "aws_s3_bucket" "static_website_bucket" {
  bucket = "connerbartels.com"

  tags = {
    Name          = "Test Static Website Bucket"
    ProvisionedBy = "Terraform"
    Environment   = "Prod"
    Project       = "Cloud Resume Challenge"
  }
}