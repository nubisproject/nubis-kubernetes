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

module "kops_cluster" {
  source  = "github.com/wanderaorg/karch/aws/cluster"
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
  master-availability-zones = "${split(",",module.info.availability_zones)}"
  master-image              = "${var.ami}"

  # Bastion
  bastion-image = "${var.ami}"

  # First minion instance group
  minion-image = "${var.ami}"
}
