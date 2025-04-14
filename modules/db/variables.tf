variable "availability_zone" {
  type = string
}

variable "username" {
  type = string
  sensitive = true
}

variable "password" {
  type = string
  sensitive = true
}

variable "db_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_groups" {
  type = list(string)
}