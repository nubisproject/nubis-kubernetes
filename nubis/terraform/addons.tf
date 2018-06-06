# These need to not be too long
locals {
  dashboard_etag = "${substr(md5(file("${path.module}/files/addons/dashboard-sso/manifest.yaml")), 0, 6)}"
  kube2iam_etag  = "${substr(md5(file("${path.module}/files/addons/kube2iam/manifest.yaml.tmpl")), 0, 6)}"
  addons_etag    = "${local.dashboard_etag}-${local.kube2iam_etag}"
}

resource "aws_s3_bucket_object" "nubis_addon" {
  bucket       = "${module.kops_bucket.name}"
  key          = "kubernetes.${module.info.hosted_zone_name}/addons/nubis/${local.addons_etag}/addon.yaml"
  source       = "${path.module}/files/addons/addon.yaml"
  etag         = "${md5(file("${path.module}/files/addons/addon.yaml"))}"
  content_type = "text/yaml"
}

resource "aws_s3_bucket_object" "dashboard_manifest" {
  bucket       = "${module.kops_bucket.name}"
  key          = "kubernetes.${module.info.hosted_zone_name}/addons/nubis/${local.addons_etag}/dashboard-sso/manifest.yaml"
  source       = "${path.module}/files/addons/dashboard-sso/manifest.yaml"
  etag         = "${local.dashboard_etag}"
  content_type = "text/yaml"
}

data "aws_caller_identity" "current" {}

data "template_file" "kube2iam_manifest" {
  template = "${file("${path.module}/files/addons/kube2iam/manifest.yaml.tmpl")}"

  vars = {
    DEFAULT_ROLE = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/nubis/readonly"
    VERSION      = "0.10.0"
  }
}

resource "aws_s3_bucket_object" "kube2iam_manifest" {
  bucket       = "${module.kops_bucket.name}"
  key          = "kubernetes.${module.info.hosted_zone_name}/addons/nubis/${local.addons_etag}/kube2iam/manifest.yaml"
  content      = "${data.template_file.kube2iam_manifest.rendered}"
  etag         = "${local.kube2iam_etag}"
  content_type = "text/yaml"
}
