module "userdata_master" {
  source            = "github.com/nubisproject/nubis-terraform//worker/userdata?ref=develop"
  region            = "${var.region}"
  nubis_domain      = "${var.nubis_domain}"
  arena             = "${var.arena}"
  environment       = "${var.environment}"
  account           = "${var.account}"
  service_name      = "${var.service_name}"
  swap_size_meg     = "0"
  nubis_user_groups = "${var.nubis_user_groups}"
  nubis_sudo_groups = "${var.nubis_sudo_groups}"
  consul_token      = "${var.consul_acl_token}"
  purpose           = "master"
}

data "template_file" "userdata_master" {
  template = "${file("${path.module}/templates/additionnal_userdata.tpl")}"

  vars {
    NAME    = "nubis-metadata"
    PAYLOAD = "${indent(6, module.userdata_master.cloudinit)}"
  }
}

module "userdata_node" {
  source            = "github.com/nubisproject/nubis-terraform//worker/userdata?ref=develop"
  region            = "${var.region}"
  nubis_domain      = "${var.nubis_domain}"
  arena             = "${var.arena}"
  environment       = "${var.environment}"
  account           = "${var.account}"
  service_name      = "${var.service_name}"
  swap_size_meg     = "0"
  nubis_user_groups = "${var.nubis_user_groups}"
  nubis_sudo_groups = "${var.nubis_sudo_groups}"
  consul_token      = "${var.consul_acl_token}"
  purpose           = "node"
}

data "template_file" "userdata_node" {
  template = "${file("${path.module}/templates/additionnal_userdata.tpl")}"

  vars {
    NAME    = "nubis-metadata"
    PAYLOAD = "${indent(6, module.userdata_node.cloudinit)}"
  }
}

module "userdata_bastion" {
  source            = "github.com/nubisproject/nubis-terraform//worker/userdata?ref=develop"
  region            = "${var.region}"
  nubis_domain      = "${var.nubis_domain}"
  arena             = "${var.arena}"
  environment       = "${var.environment}"
  account           = "${var.account}"
  service_name      = "${var.service_name}"
  swap_size_meg     = "0"
  nubis_user_groups = "${var.nubis_user_groups}"
  nubis_sudo_groups = "${var.nubis_sudo_groups}"
  consul_token      = "${var.consul_acl_token}"
  purpose           = "bastion"
}

data "template_file" "userdata_bastion" {
  template = "${file("${path.module}/templates/additionnal_userdata.tpl")}"

  vars {
    NAME    = "nubis-metadata"
    PAYLOAD = "${indent(6, module.userdata_bastion.cloudinit)}"
  }
}
