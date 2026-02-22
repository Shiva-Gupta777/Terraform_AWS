variable "number_list" {
  type = list(number)
}


variable "objects_list" {
  type = list(object({
    firstname = string
    lastname  = string
  }))
}

variable "numbers_map" {
  type = map(number)
}

// converting maps to list list inot maps 

variable "users" {
  type = list(object({
    username = string
    role     = string
  }))
}