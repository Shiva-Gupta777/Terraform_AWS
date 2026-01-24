
# Terraform & Provider

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.28.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}


# RDS Instance 


resource "aws_db_instance" "simple_rds" {
  identifier        = "simple-rds-db"

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"

  allocated_storage = 20
  storage_type      = "gp2"

  db_name           = "testdb"
  username          = "admin"
  password          = "Admin12345!"

  publicly_accessible = false
  skip_final_snapshot = true
  deletion_protection = false

  tags = {
    Name = "Simple-RDS"
  }
}
