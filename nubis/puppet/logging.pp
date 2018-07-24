class { 'fluentd':
  service_ensure => stopped
}

# Ugh
if $::osfamily == 'redhat' {
  package { 'gcc-c++':
    ensure => installed,
    before =>  Fluentd::Install_plugin['kubernetes_metadata_filter'],
  }
}

fluentd::install_plugin { 'kubernetes_metadata_filter':
  ensure      => '2.0.0',
  plugin_type => 'gem',
  plugin_name => 'fluent-plugin-kubernetes_metadata_filter',
}

file { '/etc/td-agent/config.d/kubernetes.conf':
  ensure => file,
  owner  => 'td-agent',
  group  => 'td-agent',
  mode   => '0644',
  source =>  'puppet:///nubis/files/kubernetes-fluent.conf',
}

