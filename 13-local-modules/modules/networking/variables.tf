variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"


  validation {
 
  condition     = can(cidrnetmask(var.vpc_cidr))
  error_message = "The VPC CIDR must be a valid CIDR block."
}

}