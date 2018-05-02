if $osfamily == 'Debian' {
  file { '/etc/update-motd.d/55-nubis-welcome':
    source => 'puppet:///nubis/files/nubis-welcome', #lint:ignore:puppet_url_without_modules
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  exec { 'motd_update':
    command => $motd_update_command,
    require => File['/etc/update-motd.d/55-nubis-welcome'],
  }
}
