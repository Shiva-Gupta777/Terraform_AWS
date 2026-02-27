
## General information ##

variable "project_name" {
  type        = string
  description = "The project name. Used to name the RDS instance and add relevant tags."
}

## DB configuration ##

variable "instance_class" {
  type        = string
  default     = "db.t3.micro"
  description = "The instance class used to create the RDS instance. Requires a free-tier instance class."

  validation {
    condition     = contains(["db.t3.micro"], var.instance_class)
    error_message = "Only db.t3.micro is allowed due to free tier."
  }
}

variable "storage_size" {
  type        = number
  default     = 10
  description = "The amount of storage to allocate to the RDS instance. Should be between 5GB and 10GB."

  validation {
    condition     = var.storage_size >= 5 && var.storage_size <= 10
    error_message = "DB storage must be between 5GB and 10GB."
  }
}


variable "engine" {
  type        = string
  default     = "postgres_latest"
  description = "Which engine to use for the RDS instance. Currently only postgres is supported."


  validation {
    condition     = contains(["postgres_latest", "postgres14"], var.engine)
    error_message = "Engine must be postgres_latest or postgres14."
  }
}


## DB credentials ##

variable "credentials" {
  type = object({
    username = string
    password = string
  })

  sensitive   = true
  description = "The root username and password for the RDS instance creation."


  validation {
    condition = (
      length(regexall("[A-Za-z]+", var.credentials.password)) > 0 &&
      length(regexall("[0-9]+", var.credentials.password)) > 0 &&
      length(regexall("^[A-Za-z0-9]{6,}$", var.credentials.password)) > 0
    )

    error_message = <<EOT
Password must:  
1. Contain at least one letter
2. Contain at least one digit
3. Be at least six characters long
EOT
  }

}


## DB network ##


variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs to deploy the RDS instance in"
}


variable "security_group_ids" {
  type        = list(string)
  description = "Security group IDs to attach to the RDS instance"
}
