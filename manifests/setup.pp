class nagiosneutron::setup {
  file { '/etc/nagios/nrpe.d/nrpe_command.cfg':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service['nagios-nrpe-server'],
    require => Package['nagios-nrpe-server'],
  }
  class { 'nagiosneutron::setup::host':
    require => [ File['/etc/nagios/nrpe.cfg'], Package['nagios-nrpe-plugin', 'nagios-nrpe-server'] ],
  } ->
  class { 'nagiosneutron::setup::services':
    service_list          => $::nagiosneutron::service_list,
  } ->
  class { 'nagiosneutron::setup::files': } ->
  class { 'nagiosneutron::setup::commands':
    service_list          => $::nagiosneutron::service_list,
    ovs_bridge            => $::nagiosneutron::ovs_bridge,
  }
}
