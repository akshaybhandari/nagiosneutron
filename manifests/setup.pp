class nagiosneutron::setup {
  class { 'nagiosneutron::setup::services':
    service_list          => $::nagiosneutron::service_list,
  } ->
  class { 'nagiosneutron::setup::files': } ->
  class { 'nagiosneutron::setup::commands':
    service_list          => $::nagiosneutron::service_list,
    ovs_bridge            => $::nagiosneutron::ovs_bridge,
  }
}
