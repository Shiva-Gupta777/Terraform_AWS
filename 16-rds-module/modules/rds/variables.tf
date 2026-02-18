variable "project_name" {
  type = string
}

variable "instance_class" {
  type = string

  validation {
    condition     = contains(["db.t3.micro"], var.instance_class)
    error_message = "Only db.t3.micro is allowed due to free tier."
  }
}


variable "storage_size" {
  type = number

  validation {
    condition     = var.storage_size >= 5 && var.storage_size <= 10
    error_message = "DB storage must be between 5GB and 10GB."
  }
}


variable "engine" {
  type = string

  validation {
    condition     = contains(["postgres_latest", "postgres14"], var.engine)
    error_message = "Engine must be postgres_latest or postgres14."
  }
}


variable "credentials" {
  type = object({
    username = string
    password = string
  })

  sensitive = true


  validation {
  condition = (
    length(regexall("[A-Za-z]+", var.credentials.password)) > 0 &&
    length(regexall("[0-9]+", var.credentials.password)) > 0 &&
    length(regexall("[A-Za-z0-9]{6,}", var.credentials.password)) > 0
  )

  error_message = <<EOT
Password must:
1. Contain at least one letter
2. Contain at least one digit
3. Be at least six characters long
EOT
  }

}
