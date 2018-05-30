variable "account" {}

variable "region" {}

variable "arena" {
  default = "core"
}

variable "purpose" {
  type    = "string"
  default = "kubernetes"
}

variable "nubis_domain" {
  type    = "string"
  default = "nubis.allizom.org"
}

variable "environment" {
  default = "stage"
}

variable "service_name" {}

variable "ami" {}

variable "nubis_sudo_groups" {
  default = "nubis_global_admins"
}

variable "nubis_user_groups" {
  default = ""
}

variable "consul_acl_token" {
  type    = "string"
  default = "anonymous"
}

variable "ssh_pubkey" {
  type    = "string"
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC0/tR0k8b6gIQpd6IHyEJdzmGur60ShmOdQGpBoF7IPMBWTHgc5w3CTcqvK6aJ6GpZHyybi9D9EON4+1WZTf9tcsdUP8kyVOs66sw26FWeCri2k1zomsGP9Ysr3bSUe3dpi5vipk1PDXpaD6wYs/eEtQxO1U1wRCGEGclRdh5G8UbOMwrPIHvQd77ma5RyXzd36htzFtsKnuyTtG7xHGPphzVqLZmiDZeyxbr3mCuaMBW30syEKviiVbMo4RsmDqzR3N2ltInGKYgZpCW7fd7KrZL/G0oi/XS+Up5MvmYSsP2tYNx909CWFpWDsXEPMNddl7ZYizHXLbLexU8+0h5j nubis"
}
