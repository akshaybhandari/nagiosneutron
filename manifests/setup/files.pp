class nagiosneutron::setup::files {
  file { "check_ovs_bridge.sh_${hostname}":
    ensure  => present,
    path    => '/usr/lib/nagios/plugins/privileged/check_ovs_bridge.sh',
    source  => 'puppet:///modules/nagiosneutron/check_ovs_bridge.sh',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => File["nagios_privileged_${hostname}"]
  }
}
