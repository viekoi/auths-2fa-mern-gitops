variable "env" {
  description = "Environment name."
  type        = string
}

variable "app_name" {
  description = "App name."
  type        = string
}

variable "repository_names" {
    description = "repository names"
    type = list(string)
}


variable "region" {
  description = "Region name."
  type        = string
}




