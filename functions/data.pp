function puppet::data() {

  $base_params = {
    'puppet::version'         => 'installed',
    'puppet::conf'            => undef,
    'puppet::conf_merge'      => false,
    'puppet::hiera'           => undef,
    'puppet::repo_manage'     => false,
    'puppet::repo_location'   => 'http://apt.puppet.com',
    'puppet::repo_release'    => $facts['lsbdistcodename'],
    'puppet::repo_repos'      => 'PC1',
    'puppet::repo_key'        => '47B320EB4C7C375AA9DAE1A01054B7A24BD6EC30',
    'puppet::repo_key_source' => 'https://apt.puppet.com/keyring.gpg',
    'puppet::service_type'    => undef,
    'puppet::service_iterval' => 30,
    'puppet::server::ssl'      => true,
    'puppet::server::port'     => '8140',
    'puppet::server::gems'     => undef,
    'puppet::server::autosign' => undef,
    'puppet::server::haproxy::server_names'      => [$facts['fqdn']],
    'puppet::server::haproxy::server_addresses'  => [$facts['ipaddress']],
    'puppet::server::haproxy::server_port'       => '8140',
    'puppet::server::haproxy::ca_server_name'    => $facts['fqdn'],
    'puppet::server::haproxy::ca_server_address' => $facts['ipaddress'],
    'puppet::server::haproxy::ca_server_port'    => '8140',
    'puppet::server::haproxy::repo_manage'       => true,
  }

}
