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

locals {
  security_groups       = "${concat(split(",",module.info.instance_security_groups), list(aws_security_group.kubernetes.id))}"
  security_groups_count = "${1+length(split(",",module.info.instance_security_groups))}"
}

module "kops_cluster" {
  #source  = "github.com/wanderaorg/karch/aws/cluster"
  #source  = "../aws/cluster"
  source = "github.com/tinnightcap/karch//aws/cluster?ref=nubis-compat"

  kubernetes-version = "v1.9.7"

  aws-region = "${var.region}"

  # Networking & connectivity
  container-networking      = "weave"
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
  master-additional-sgs        = "${local.security_groups}"
  master-additional-sgs-count  = "${local.security_groups_count}"
  master-additional-user-data  = "${data.template_file.user_data_cloudconfig.rendered}"

  # Bastion
  bastion-image                 = "${var.ami}"
  bastion-additional-sgs        = "${local.security_groups}"
  bastion-additional-sgs-count  = "${local.security_groups_count}"
  bastion-additional-user-data  = "${data.template_file.user_data_cloudconfig.rendered}"

  # First minion instance group
  minion-image                 = "${var.ami}"
  minion-additional-sgs        = "${local.security_groups}"
  minion-additional-sgs-count  = "${local.security_groups_count}"
  minion-additional-user-data  = "${data.template_file.user_data_cloudconfig.rendered}"
  min-minions                  = 2
}

resource "aws_security_group" "kubernetes" {
  name_prefix = "${var.service_name}-${var.arena}-${var.environment}-ssh-"

  vpc_id = "${module.info.vpc_id}"

  tags = {
    Name        = "${var.service_name}-${var.arena}-${var.environment}-ssh"
    Arena       = "${var.arena}"
    Region      = "${var.region}"
    Environment = "${var.environment}"
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    security_groups = [
      "${module.info.ssh_security_group}",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
