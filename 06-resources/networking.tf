resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    ManagedBy = "Terraform"
    Project   = "06-resources"
    Name      = "06-resources"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"

  tags = {
    ManagedBy = "Terraform"
    Project   = "06-resources"
    Name      = "06-resources-public-subnet"
  }
}