class nagiosneutron::setup::services (
  $service_list = ['openvswitch-switch'],
) {
  #OpenStack related checks
  each($service_list) |$service| {
    @@nagios_service { "check_service_${service}_${hostname}":
      check_command       => "check_nrpe_1arg!check_service_${service}",
      use                 => "generic-service",
      host_name           => "$fqdn",
      service_description => "check_service_${service}",
    }
  }
  @@nagios_service { "check_ovs_bridge_${hostname}":
    check_command       => "check_nrpe_1arg!check_ovs_bridge",
    use                 => "generic-service",
    host_name           => "$fqdn",
    service_description => "OVS_external_bridge",
  }
}
