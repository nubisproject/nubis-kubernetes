provider "aws" {
  region = "${var.region}"
}

module "info" {
  source      = "github.com/nubisproject/nubis-terraform//info?ref=v2.2.0"
  region      = "${var.region}"
  environment = "${var.environment}"
  account     = "${var.account}"
}

data "aws_subnet" "private" {
  count = "${length(split(",",module.info.private_subnets))}"
  id    = "${element(split(",",module.info.private_subnets),count.index)}"
}

data "aws_subnet" "public" {
  count = "${length(split(",",module.info.public_subnets))}"
  id    = "${element(split(",",module.info.public_subnets),count.index)}"
}

module "kops_bucket" {
  source       = "github.com/nubisproject/nubis-terraform//bucket?ref=v2.2.0"
  region       = "${var.region}"
  environment  = "${var.environment}"
  account      = "${var.account}"
  service_name = "${var.service_name}"
  purpose      = "kops"
  role_cnt     = "0"
  role         = ""
}

data "template_file" "nubis_metadata" {
  #count    = "${var.enabled}"
  template = "${file("${path.module}/templates/userdata.tpl")}"

  vars {
    NUBIS_PROJECT       = "${var.service_name}"
    CONSUL_ACL_TOKEN    = "${var.consul_acl_token}"
    NUBIS_PURPOSE       = "${var.purpose}"
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

data "template_file" "user_data_cloudconfig" {
  #count    = "${var.enabled}"
  template = "${file("${path.module}/templates/userdata_cloudconfig.tpl")}"

  vars {
    NAME    = "nubis-metadata"
    PAYLOAD = "${base64encode(data.template_file.nubis_metadata.rendered)}"

    # The nubis-metadata script looks here for it
    LOCATION = "/var/cache/nubis/userdata"
  }
}

module "kops_cluster" {
  #source  = "github.com/wanderaorg/karch/aws/cluster"
  #source  = "../aws/cluster"
  source = "github.com/tinnightcap/karch//aws/cluster?ref=nubis-compat"

  version = "1.7.1"

  aws-region = "${var.region}"

  # Networking & connectivity
  vpc-id                    = "${module.info.vpc_id}"
  availability-zones        = "${split(",",module.info.availability_zones)}"
  vpc-private-subnet-ids    = "${split(",",module.info.private_subnets)}"
  vpc-public-subnet-ids     = "${split(",",module.info.public_subnets)}"
  vpc-private-cidrs         = "${data.aws_subnet.private.*.cidr_block}"
  vpc-public-cidrs          = "${data.aws_subnet.public.*.cidr_block}"
  vpc-cidr-block            = "${module.info.network_cidr}"
  nat-gateways              = [""]
  kops-topology             = "private"
  trusted-cidrs             = ["0.0.0.0/0"]
  admin-ssh-public-key-path = "${var.ssh_key_file}"

  # DNS
  main-zone-id = "${module.info.hosted_zone_id}"
  cluster-name = "kubernetes.${module.info.hosted_zone_name}"

  # Kops & Kuberntetes
  kops-state-bucket = "${module.kops_bucket.name}"

  # Master
  master-availability-zones    = "${split(",",module.info.availability_zones)}"
  master-image                 = "${var.ami}"
  master-additional-sgs        = "${split(",",module.info.instance_security_groups)}"
  master-additional-sgs-count  = "${length(split(",",module.info.instance_security_groups))}"
  master-addidtional-user-data = "${data.template_file.user_data_cloudconfig.rendered}"

  # Bastion
  bastion-image                 = "${var.ami}"
  bastion-additional-sgs        = "${split(",",module.info.instance_security_groups)}"
  bastion-additional-sgs-count  = "${length(split(",",module.info.instance_security_groups))}"
  bastion-addidtional-user-data = "${data.template_file.user_data_cloudconfig.rendered}"

  # First minion instance group
  minion-image                 = "${var.ami}"
  minion-additional-sgs        = "${split(",",module.info.instance_security_groups)}"
  minion-additional-sgs-count  = "${length(split(",",module.info.instance_security_groups))}"
  minion-addidtional-user-data = "${data.template_file.user_data_cloudconfig.rendered}"
}
