# Fixes kubernetes master so that a reload or restart
# doesn't break consul
file { '/etc/nubis.d/01-kubernetes-startup':
  ensure => file,
  owner  => root,
  group  => root,
  mode   => '0755',
  source =>  'puppet:///nubis/files/kubernetes-startup',
}
