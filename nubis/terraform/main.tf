provider "aws" {
  region = "${var.region}"
}

provider "local" {
  version = "~> 0.1"
}

module "info" {
  source      = "github.com/nubisproject/nubis-terraform//info?ref=v2.2.0"
  region      = "${var.region}"
  environment = "${var.environment}"
  account     = "${var.account}"
}

data "aws_subnet" "private" {
  count = "${var.enabled * length(split(",",module.info.private_subnets))}"
  id    = "${element(split(",",module.info.private_subnets),count.index)}"
}

data "aws_subnet" "public" {
  count = "${var.enabled * length(split(",",module.info.public_subnets))}"
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

locals {
  kubernetes_sg         = "${list(element(concat(aws_security_group.kubernetes.*.id, list("")),0))}"
  security_groups       = "${concat(split(",",module.info.instance_security_groups), local.kubernetes_sg)}"
  security_groups_count = "${length(local.kubernetes_sg) > 1 ? (1+length(split(",",module.info.instance_security_groups))) : (length(split(",",module.info.instance_security_groups)))}"
  ssh_pubkey_path       = "${path.module}/nubis.pub"
}

resource "local_file" "ssh_pubkey" {
  count    = "${var.enabled}"
  content  = "${var.ssh_pubkey}"
  filename = "${local.ssh_pubkey_path}"
}

module "kops_cluster" {
  #source  = "github.com/wanderaorg/karch/aws/cluster"
  #source  = "../aws/cluster"
  source = "github.com/tinnightcap/karch//aws/cluster?ref=nubis-compat"

  enabled = "${var.enabled}"

  kubernetes-version = "v1.9.7"

  addons = [
    "manifest: monitoring-standalone",
    "manifest: kubernetes-dashboard",
  ]

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
  admin-ssh-public-key-path = "${local.ssh_pubkey_path}"
  rbac                      = "true"

  # DNS
  main-zone-id = "${module.info.hosted_zone_id}"
  cluster-name = "kubernetes.${var.environment}.${module.info.hosted_zone_name}"

  # Kops & Kuberntetes
  kops-state-bucket = "${module.kops_bucket.name}"

  # Master
  master-availability-zones   = "${split(",",module.info.availability_zones)}"
  master-image                = "${var.ami}"
  master-machine-type         = "${var.kubernetes_master_type}"
  master-additional-sgs       = "${local.security_groups}"
  master-additional-sgs-count = "${local.security_groups_count}"
  master-additional-user-data = "${data.template_file.userdata_master.rendered}"
  master-update-interval      = 5

  # Bastion
  bastion-image                = "${var.ami}"
  bastion-additional-sgs       = "${local.security_groups}"
  bastion-additional-sgs-count = "${local.security_groups_count}"
  bastion-additional-user-data = "${data.template_file.userdata_bastion.rendered}"

  # First minion instance group
  minion-image                = "${var.ami}"
  minion-machine-type         = "${var.kubernetes_node_type}"
  minion-additional-sgs       = "${local.security_groups}"
  minion-additional-sgs-count = "${local.security_groups_count}"
  minion-additional-user-data = "${data.template_file.userdata_node.rendered}"
  minion-update-interval      = 4
  min-minions                 = "${var.kubernetes_node_minimum}"
}

resource "aws_security_group" "kubernetes" {
  count = "${var.enabled}"

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

  # FIXME: We should figure out how to do this only for masters
  #        same goes for everything else except for kubelet
  # master API server monitoring
  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    security_groups = [
      "${module.info.monitoring_security_group}",
    ]
  }

  # kube-scheduler monitoring
  ingress {
    from_port = 10251
    to_port   = 10251
    protocol  = "tcp"

    security_groups = [
      "${module.info.monitoring_security_group}",
    ]
  }

  # kube-controller-scheduler monitoring
  ingress {
    from_port = 10252
    to_port   = 10252
    protocol  = "tcp"

    security_groups = [
      "${module.info.monitoring_security_group}",
    ]
  }

  # kubelet monitoring
  ingress {
    from_port = 10255
    to_port   = 10255
    protocol  = "tcp"

    security_groups = [
      "${module.info.monitoring_security_group}",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
