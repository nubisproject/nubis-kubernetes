data "template_file" "nubis_metadata_master" {
  #count    = "${var.enabled}"
  template = "${file("${path.module}/templates/userdata.tpl")}"

  vars {
    NUBIS_PROJECT       = "${var.service_name}-master"
    CONSUL_ACL_TOKEN    = "${var.consul_acl_token}"
    NUBIS_PURPOSE       = "${var.purpose}-master"
    NUBIS_ENVIRONMENT   = "${var.environment}"
    NUBIS_ARENA         = "${var.arena}"
    NUBIS_DOMAIN        = "${var.nubis_domain}"
    NUBIS_ACCOUNT       = "${var.account}"
    NUBIS_STACK         = "${var.service_name}-${var.environment}"
    NUBIS_SUDO_GROUPS   = "${var.nubis_sudo_groups}"
    NUBIS_USER_GROUPS   = "${var.nubis_user_groups}"
    NUBIS_SWAP_SIZE_MEG = 0
  }
}

data "template_file" "user_data_cloudconfig_master" {
  #count    = "${var.enabled}"
  template = "${file("${path.module}/templates/userdata_cloudconfig.tpl")}"

  vars {
    NAME    = "nubis-metadata"
    PAYLOAD = "${base64encode(data.template_file.nubis_metadata_master.rendered)}"

    # The nubis-metadata script looks here for it
    LOCATION = "/var/cache/nubis/userdata"
  }
}

data "template_file" "nubis_metadata_node" {
  #count    = "${var.enabled}"
  template = "${file("${path.module}/templates/userdata.tpl")}"

  vars {
    NUBIS_PROJECT       = "${var.service_name}-node"
    CONSUL_ACL_TOKEN    = "${var.consul_acl_token}"
    NUBIS_PURPOSE       = "${var.purpose}-node"
    NUBIS_ENVIRONMENT   = "${var.environment}"
    NUBIS_ARENA         = "${var.arena}"
    NUBIS_DOMAIN        = "${var.nubis_domain}"
    NUBIS_ACCOUNT       = "${var.account}"
    NUBIS_STACK         = "${var.service_name}-${var.environment}"
    NUBIS_SUDO_GROUPS   = "${var.nubis_sudo_groups}"
    NUBIS_USER_GROUPS   = "${var.nubis_user_groups}"
    NUBIS_SWAP_SIZE_MEG = 0
  }
}

data "template_file" "user_data_cloudconfig_node" {
  #count    = "${var.enabled}"
  template = "${file("${path.module}/templates/userdata_cloudconfig.tpl")}"

  vars {
    NAME    = "nubis-metadata"
    PAYLOAD = "${base64encode(data.template_file.nubis_metadata_node.rendered)}"

    # The nubis-metadata script looks here for it
    LOCATION = "/var/cache/nubis/userdata"
  }
}

data "template_file" "nubis_metadata_bastion" {
  #count    = "${var.enabled}"
  template = "${file("${path.module}/templates/userdata.tpl")}"

  vars {
    NUBIS_PROJECT       = "${var.service_name}-bastion"
    CONSUL_ACL_TOKEN    = "${var.consul_acl_token}"
    NUBIS_PURPOSE       = "${var.purpose}-bastion"
    NUBIS_ENVIRONMENT   = "${var.environment}"
    NUBIS_ARENA         = "${var.arena}"
    NUBIS_DOMAIN        = "${var.nubis_domain}"
    NUBIS_ACCOUNT       = "${var.account}"
    NUBIS_STACK         = "${var.service_name}-${var.environment}"
    NUBIS_SUDO_GROUPS   = "${var.nubis_sudo_groups}"
    NUBIS_USER_GROUPS   = "${var.nubis_user_groups}"
    NUBIS_SWAP_SIZE_MEG = 0
  }
}

data "template_file" "user_data_cloudconfig_bastion" {
  #count    = "${var.enabled}"
  template = "${file("${path.module}/templates/userdata_cloudconfig.tpl")}"

  vars {
    NAME    = "nubis-metadata"
    PAYLOAD = "${base64encode(data.template_file.nubis_metadata_bastion.rendered)}"

    # The nubis-metadata script looks here for it
    LOCATION = "/var/cache/nubis/userdata"
  }
}

