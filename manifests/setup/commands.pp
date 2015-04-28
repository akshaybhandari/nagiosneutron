class nagiosneutron::setup::commands (
  $service_list = ['openvswitch-switch'],
  $os_type = linux,
  $ovs_bridge = 'br-ex',
) {
  case $::osfamily {
    'redhat': {
      $sudo_path = '/bin/sudo'
    }
    'debian': {
      $sudo_path = '/usr/bin/sudo'
    }
    default: { fail("No such osfamily: ${::osfamily} yet defined") }
  }

  #basic checks
  file_line { "check_users_${hostname}":
    ensure  => present,
    path    => '/etc/nagios/nrpe.d/nrpe_command.cfg',
    line    => 'command[check_users]=/usr/lib/nagios/plugins/check_users -w 5 -c 10',
    require => File['/etc/nagios/nrpe.d/nrpe_command.cfg'],
    notify  => Service['nagios-nrpe-server'],
  }
  file_line { "check_memory_${hostname}":
    ensure  => present,
    path    => '/etc/nagios/nrpe.d/nrpe_command.cfg',
    line    => 'command[check_memory]=/usr/lib/nagios/plugins/check_memory.sh -w 80 -c 90',
    require => File['/etc/nagios/nrpe.d/nrpe_command.cfg'],
    notify  => Service['nagios-nrpe-server'],
  }
  file_line { "check_all_disks_${hostname}":
    ensure  => present,
    path    => '/etc/nagios/nrpe.d/nrpe_command.cfg',
    line    => 'command[check_all_disks]=/usr/lib/nagios/plugins/check_disk -w 20% -c 10%',
    require => File['/etc/nagios/nrpe.d/nrpe_command.cfg'],
    notify  => Service['nagios-nrpe-server'],
  }
  file_line { "check_load_${hostname}":
    ensure  => present,
    path    => '/etc/nagios/nrpe.d/nrpe_command.cfg',
    line    => 'command[check_load]=/usr/lib/nagios/plugins/check_load -w 15,10,5 -c 30,25,20',
    require => File['/etc/nagios/nrpe.d/nrpe_command.cfg'],
    notify  => Service['nagios-nrpe-server'],
  }

  #OpenStack related checks
  each($service_list) |$service| {
    file_line { "check_service_${service}_${hostname}":
      ensure  => present,
      path    => '/etc/nagios/nrpe.d/nrpe_command.cfg',
      line    => "command[check_service_${service}]=/usr/lib/nagios/plugins/check_service.sh -o ${os_type} -s ${service}",
      require => File['/etc/nagios/nrpe.d/nrpe_command.cfg'],
      notify  => Service['nagios-nrpe-server'],
    }
  }
  file_line { "check_ovs_bridge_${hostname}":
    ensure  => present,
    path    => '/etc/nagios/nrpe.d/nrpe_command.cfg',
    line    => "command[check_ovs_bridge]=${sudo_path} /usr/lib/nagios/plugins/privileged/check_ovs_bridge.sh -b ${ovs_bridge}",
    require => File['/etc/nagios/nrpe.d/nrpe_command.cfg'],
    notify  => Service['nagios-nrpe-server'],
  }
}
