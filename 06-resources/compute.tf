resource "aws_instance" "ubuntu" {
  ami                         = "ami-051a31ab2f4d498f5"
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public.id

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"

  }

   tags = {
      Name = "VPC-EC2-TF"
    }
}