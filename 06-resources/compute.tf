resource "aws_instance" "ubuntu" {
  ami                         = "ami-051a31ab2f4d498f5"
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public.id

  vpc_security_group_ids = [
    aws_security_group.public_http_traffic.id
  ]

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"

  }

   tags = merge(local.common_tags, {
    Name = "VPC-EC2-Instance"
  })
}



resource "aws_security_group" "public_http_traffic" {
  description = "Security group allowing traffic on ports 80 and 443"
  name        = "public-http-traffic"
  vpc_id      = aws_vpc.main.id


   tags = merge(local.common_tags, {
    Name = "SECURITY-GROUP-PUBLIC-HTTP-TRAFFIC",
  })
}

// Allow inbound HTTP traffic from anywhere

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}


// Allow inbound HTTPS traffic from anywhere

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

