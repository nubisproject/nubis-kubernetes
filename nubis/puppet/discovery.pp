include nubis_discovery

# Strip the nubis- portion of project name, just to be tidy
nubis::discovery::service { split($project_name, '-')[1]:
  tags => [
    '%%PURPOSE%%',
    'kubelet',
  ],
  http => 'http://localhost:10255/healthz',
}

