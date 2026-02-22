locals {
  name = "Shiva Gupta"
  age  = 25
}

output "example_one" {
  value = upper(local.name)
}

output "example_onee" {
  value = startswith(lower(local.name), "shiva")
}
