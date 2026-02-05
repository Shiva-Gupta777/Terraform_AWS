terraform {
    required_version = ">=1.7.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.31.0"
    }
  }
}

#ami-0030e4319cbf4dbf2 - eu-east-1
# "ami-0f27749973e2399b6" - eu-west-1
#  ami-0ff91eb5c6fe7cc86  = ap-south-1

provider "aws" {
  region = var.aws_region
}
