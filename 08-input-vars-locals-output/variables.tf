variable "ec2_instance_type" {
  type        = string
  default     = "t3.micro"
  description = "The size of ec2"

  // Validation block to ensure only specific instance types are allowed

  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.ec2_instance_type)
    error_message = "Only t2.micro and t3.micro are supported."
  }
}

# variable "ec2_volume_type" {
#   type        = string
#   description = "The volume type between GP2 and GP3"
# }

# variable "ec2_volume_size" {
#   type        = number
#   description = "The size in GB of the root block volume"
# }


# Object Function 

variable "ec2_volume_config" {
  type = object({
    size = number
    type = string
  })

  default = {
    size = 10
    type = "gp3"
  }

  description = "Size and type of the root block volume for EC2 instances"
}



variable "additional_tags" {
  type    = map(string)
  default = {}
}








