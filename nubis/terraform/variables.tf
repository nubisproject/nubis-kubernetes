variable "account" {}

variable "region" {}

variable "arena" {
  default = "core"
}

variable "environment" {
  default = "stage"
}

variable "service_name" {}

variable "ami" {}

variable "ssh_key_file" {
  default = ""
}

variable "ssh_key_name" {
  default = ""
}

variable "nubis_sudo_groups" {
  default = "nubis_global_admins"
}

variable "nubis_user_groups" {
  default = ""
}
