# == Class: puppet::server::haproxy
#
# Provides load balancing service for puppet server
#
# === Parameters
#
# [*server_names*]
#   Servers which are part of the pool
#
# [*server_addresses*]
#   IP addresses of servers which are part of the pool
#
# [*server_port*]
#   Port the servers in the pool are listening on
#
# [*ca_server_name*]
#   Name of the CA server
#
# [*ca_server_address*]
#   IP address of the CA server
#
# [*ca_server_port*]
#   Port the CA server is listening on
#
# [*repo_manage*]
#   Whether to manage the HAProxy repository pins
#
class puppet::server::haproxy (
  Array[String] $server_names,
  Array[String] $server_addresses,
  String $server_port,
  String $ca_server_name,
  String $ca_server_address,
  String $ca_server_port,
  Boolean $repo_manage,
) {

  include ::haproxy
  include ::puppet::server::haproxy::certificate

  $server_addresses.each |$address| { validate_ip_address($address) }
  validate_ip_address($ca_server_address)

  if repo_manage and versioncmp($::operatingsystemrelease, '14.04') == 0 {

    apt::pin { 'trusty-backports':
      packages => '*',
      release  => 'trusty-backports',
      priority => 500,
    }

    # Ensure the pin is in place before installing the software
    Apt::Pin['trusty-backports'] -> Class['haproxy']

  }

  haproxy::frontend { 'puppet':
    mode    => 'http',
    bind    => {
      ':8140' => [
        'ssl',
        'no-sslv3',
        'ciphers HIGH:!aNULL:!MD5',
        'crt /etc/ssl/private/puppet-server.crt',
        'ca-file /etc/puppetlabs/puppet/ssl/certs/ca.pem',
        'verify optional',
      ],
    },
    options => {
      'option'          => 'http-server-close',
      'default_backend' => 'puppet',
      'use_backend'     => [
        'puppetca if { path -m sub certificate }'
      ],
      'http-request'    => [
        'set-header X-Client-Verify SUCCESS if { ssl_c_verify 0 }',
        'set-header X-Client-Verify NONE unless { ssl_c_verify 0 }',
        'set-header X-Client-DN %{+Q}[ssl_c_s_dn]',
        # No X-Client-Cert sadly
      ],
    },
  }

  haproxy::backend { 'puppet':
    collect_exported => false,
    options          => {
      'mode' => 'http',
    },
  }

  haproxy::balancermember { 'puppet':
    listening_service => 'puppet',
    ports             => $server_port,
    server_names      => $server_names,
    ipaddresses       => $server_addresses,
    options           => 'check',
  }

  haproxy::backend { 'puppetca':
    collect_exported => false,
    options          => {
      'mode' => 'http',
    },
  }

  haproxy::balancermember { 'puppetca':
    listening_service => 'puppetca',
    ports             => $ca_server_port,
    server_names      => $ca_server_name,
    ipaddresses       => $ca_server_address,
    options           => 'check',
  }

  # Ensure the SSL certificate is created before starting haproxy
  Class['::puppet::server::haproxy::certificate'] -> Class['haproxy']

}
