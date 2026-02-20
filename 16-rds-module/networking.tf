
data "aws_vpc" "default" {
  default = true
}

resource "aws_vpc" "custom" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "proj04-custom"
  }
}

moved {
  from = aws_subnet.allowed
  to = aws_subnet.private1
}


resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.custom.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "subnets custom vpc -private1"
    access = "private"
  }
}



resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.custom.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subnets custom vpc-private2"
    access = "private"
  }
}


resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.custom.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "subnets custom vpc-public"
    
  }
}







// for testing purpose only nothing to do with not allows one !

resource "aws_subnet" "not_allowed" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "172.31.128.0/24"

  tags = {
    Name = "subnets default vpc"
  }
}
