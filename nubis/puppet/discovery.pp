include nubis_discovery

# Switch to MC port once working
nubis::discovery::service { $project_name:
  tcp      => '433',
}

