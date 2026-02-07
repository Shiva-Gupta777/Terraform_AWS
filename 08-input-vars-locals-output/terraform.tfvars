ec2_instance_type = "t3.micro"

ec2_volume_config = {
  type = "gp3"
  size = 10
}

additional_tags = {
  source = "terraform.tfvars"
}
