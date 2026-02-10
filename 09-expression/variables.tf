variable "number_list" {
  type = list(number)
}


variable "objects_list" {
  type = list(object({
    firstname = string
    lastname  = string
  }))
}