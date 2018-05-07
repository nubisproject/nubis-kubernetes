file { '/usr/bin/nubis-metadata':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0755',
    source => 'puppet:///nubis/files/nubis-metadata',
}
