include nubis_discovery

nubis::discovery::service { $project_name:
  tags => [
    '%%PURPOSE%%',
    'kubelet',
  ],
  http => 'http://localhost:10255/healthz',
}

