locals {
  ec2_names = ["instance1", "instance2"]
}

//Generated AMI data source for Ubuntu 

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Owner is Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

//MOVED address without destroying anything 

moved {
  from = aws_instance.new_list[0]
  to   = aws_instance.new_list["instance1"]
}


moved {
  from = aws_instance.new_list[1]
  to   = aws_instance.new_list["instance2"]
}

// Now moving to a new resource and a module resource

moved {
  from = aws_instance.new_list["instance1"]
  to   = aws_instance.new_final
}

moved {
  from = aws_instance.new_list["instance2"]
  to   = module.compute.aws_instance.this
}

//our instance

resource "aws_instance" "new_final" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
}

// now adding the module

module "compute" {
  source = "./modules/compute"
  ami_id = data.aws_ami.ubuntu.id
}