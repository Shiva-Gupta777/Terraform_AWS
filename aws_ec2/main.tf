terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.28.0"
    }
  }
}

provider "aws" {
region = "eu-north-1"
}

resource "aws_instance" "Myserver" {
  ami           = "ami-073130f74f5ffb161"
  instance_type = "t3.micro"


  tags ={
    Name = "EC2-instance-Terraform"

  }

}