locals {
  first_names_from_splat = var.objects_list[*].firstname
}

output "first_names_from_splat" {
  value = local.first_names_from_splat
}