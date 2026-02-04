locals {
  vpc_cidr             = "10.0.0.0/16"
  private_subnets_cidr = ["10.0.1.0/24"]
  public_subnets_cidr  = ["10.0.128.0/24"]
}


data "aws_availability_zones" "azs" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.0"
  azs     = data.aws_availability_zones.azs.names
  name    = local.project_name
  cidr    = local.vpc_cidr


  private_subnets = local.private_subnets_cidr
  public_subnets  = local.public_subnets_cidr


  tags = local.common_tags



}