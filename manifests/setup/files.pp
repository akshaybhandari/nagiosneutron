class nagiosneutron::setup::files {
  file { "nagios_privileged_${hostname}":
    ensure => directory,
    path   => '/usr/lib/nagios/plugins/privileged/',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    require => Package['nagios-nrpe-server'],
  }
  file { "check_memory.sh_${hostname}":
    ensure => present,
    path   => '/usr/lib/nagios/plugins/check_memory.sh',
    source => 'puppet:///modules/nagiosneutron/check_memory.sh',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
  file { "check_ovs_bridge.sh_${hostname}":
    ensure  => present,
    path    => '/usr/lib/nagios/plugins/privileged/check_ovs_bridge.sh',
    source  => 'puppet:///modules/nagiosneutron/check_ovs_bridge.sh',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => File["nagios_privileged_${hostname}"]
  }
  file { "check_service.sh_${hostname}":
    ensure => present,
    path   => '/usr/lib/nagios/plugins/check_service.sh',
    source => 'puppet:///modules/nagiosneutron/check_service.sh',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
}
