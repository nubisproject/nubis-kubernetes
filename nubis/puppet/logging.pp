fluentd::install_plugin { 'kubernetes_metadata_input':
  ensure      => '2.0.0',
  plugin_type => 'gem',
  plugin_name => 'fluent-plugin-kubernetes_metadata_input',
}

file { '/etc/td-agent/config.d/kubernetes.conf':
  ensure => file,
  owner  => 'td-agent',
  group  => 'td-agent',
  mode   => '0644',
  source =>  'puppet:///nubis/kubernetes-fluent.conf',
}

