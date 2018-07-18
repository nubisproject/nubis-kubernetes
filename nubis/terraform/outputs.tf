output "kubernetes_state_bucket" {
  value = "${module.kops_bucket.name}"
}

output "kubernetes_cluster_name" {
  value = "kubernetes.${module.info.hosted_zone_name}"
}

output "kubernetes_api_endpoint" {
  value = "api.kubernetes.${module.info.hosted_zone_name}"
}
