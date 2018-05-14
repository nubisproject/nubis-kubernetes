include nubis_discovery

# Strip the nubis- portion of project name, just to be tidy
nubis::discovery::service { split($project_name, '-')[1]:
  tags => [
    '%%PURPOSE%%',
    'kubelet',
  ],
  http => 'http://localhost:10255/healthz',
}

# Kubelet metric discovery
nubis::discovery::service { 'kubelet-metrics':
  tags => [
    '%%PURPOSE%%',
    'metrics',
  ],
  http => 'http://localhost:10255/metrics',
}

# This exists over here because of how we build
# AMIs we build 1 AMI for master and nodes therefore
# its hard to differentiate between master and node during packer builds
file { '/etc/nubis.d/02-kube-sd':
  ensure => file,
  owner  => root,
  group  => root,
  mode   => '0755',
  source => 'puppet:///nubis/files/kube-sd.sh',
}
