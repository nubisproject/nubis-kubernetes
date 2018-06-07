# These need to not be too long
locals {
  dashboard_etag = "${md5(file("${path.module}/files/addons/dashboard-sso/manifest.yaml"))}"
  chaoskube_etag = "${md5(file("${path.module}/files/addons/chaoskube/manifest.yaml"))}"
  kube2iam_etag  = "${md5(file("${path.module}/files/addons/kube2iam/manifest.yaml.tmpl"))}"
  addons_etag    = "${substr(local.dashboard_etag, 0, 6)}-${substr(local.kube2iam_etag, 0, 6)}-${substr(local.chaoskube_etag, 0, 6)}"
}

resource "aws_s3_bucket_object" "nubis_addon" {
  count        = "${var.enabled}"
  bucket       = "${module.kops_bucket.name}"
  key          = "${local.cluster_name}/addons/nubis/${local.addons_etag}/addon.yaml"
  source       = "${path.module}/files/addons/addon.yaml"
  etag         = "${md5(file("${path.module}/files/addons/addon.yaml"))}"
  content_type = "text/yaml"
}

resource "aws_s3_bucket_object" "dashboard_manifest" {
  count        = "${var.enabled}"
  bucket       = "${module.kops_bucket.name}"
  key          = "${local.cluster_name}/addons/nubis/${local.addons_etag}/dashboard-sso/manifest.yaml"
  source       = "${path.module}/files/addons/dashboard-sso/manifest.yaml"
  etag         = "${local.dashboard_etag}"
  content_type = "text/yaml"
}

resource "aws_s3_bucket_object" "chaoskube_manifest" {
  count        = "${var.enabled}"
  bucket       = "${module.kops_bucket.name}"
  key          = "${local.cluster_name}/addons/nubis/${local.addons_etag}/chaoskube/manifest.yaml"
  source       = "${path.module}/files/addons/chaoskube/manifest.yaml"
  etag         = "${local.chaoskube_etag}"
  content_type = "text/yaml"
}

data "aws_caller_identity" "current" {}

data "template_file" "kube2iam_manifest" {
  count        = "${var.enabled}"
  template = "${file("${path.module}/files/addons/kube2iam/manifest.yaml.tmpl")}"

  vars = {
    DEFAULT_ROLE = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/nubis/readonly"
    VERSION      = "0.10.0"
  }
}

resource "aws_s3_bucket_object" "kube2iam_manifest" {
  count        = "${var.enabled}"
  bucket       = "${module.kops_bucket.name}"
  key          = "${local.cluster_name}/addons/nubis/${local.addons_etag}/kube2iam/manifest.yaml"
  content      = "${data.template_file.kube2iam_manifest.rendered}"
  content_type = "text/yaml"
}
