class { 'dnsmasq':
  reload_resolvconf => false,
  restart           => false,
  service_ensure    => 'stopped',
}

dnsmasq::dnsserver { 'consul':
  domain => 'consul',
  ip     => '127.0.0.1',
  port   => '8600'
}
