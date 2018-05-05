variable "account" {}

variable "region" {}

variable "arena" {
  default = "core"
}

variable "purpose" {
  type = "string"
  default = "kubernetes"
}

variable "nubis_domain" {
  type = "string"
  default = "nubis.allizom.org"
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

variable "consul_acl_token" {
  type = "string"
  default = "anonymous"
}

