locals {
  project_name = "public-modules-vpc"

  common_tags = {
    project   = local.project_name
    ManagedBy = "Terraform"
  }

}