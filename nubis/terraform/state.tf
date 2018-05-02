# Workaround for TF bug https://github.com/hashicorp/terraform/issues/15761
terraform {
  backend "s3" {}
}
