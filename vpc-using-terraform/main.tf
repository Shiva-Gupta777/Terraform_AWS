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

#Create a vpc
resource "aws_vpc" "MyVPC" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "My_VPC"
  }
}

#Private Subnet
resource "aws_subnet" "PrivateSubnet" {
  vpc_id     = aws_vpc.MyVPC.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "PrivateSubnet"
  }
}


#Public Subnet
resource "aws_subnet" "PublicSubnet" {
  vpc_id     = aws_vpc.MyVPC.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "PublicSubnet"
  }
}


#Internet Gateway
resource "aws_internet_gateway" "MyIGW" {
  vpc_id = aws_vpc.MyVPC.id

  tags = {
    Name = "My_IGW"
  }
}


#Routing table

resource "aws_route_table" "my_route" {
    vpc_id = aws_vpc.MyVPC.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.MyIGW.id
    }
}



#Associate public subnet with route table

resource "aws_route_table_association" "public_sub" {
   route_table_id = aws_route_table.my_route.id
   subnet_id = aws_subnet.PublicSubnet.id
}


# 1 - 1 Instance 

# EC2 in Public Subnet
resource "aws_instance" "PublicEC2" {
  ami                         = "ami-0c1ac872a8b1d7b7c"   # Amazon Linux 2 (eu-north-1)
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.PublicSubnet.id
  associate_public_ip_address = true

  tags = {
    Name = "Public-EC2"
  }
}

# EC2 in Private Subnet
resource "aws_instance" "PrivateEC2" {
  ami           = "ami-0c1ac872a8b1d7b7c"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.PrivateSubnet.id

  tags = {
    Name = "Private-EC2"
  }
}