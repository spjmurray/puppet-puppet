# == Class: puppet::server::haproxy::certificate
#
# Manages the create of HAProxy certificates
#
class puppet::server::haproxy::certificate {

  concat { '/etc/ssl/private/puppet-server.crt':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0400',
  } 

  concat::fragment { 'puppet-server-key':
    target => '/etc/ssl/private/puppet-server.crt',
    order  => '10',
    source => "/etc/puppetlabs/puppet/ssl/private_keys/${::fqdn}.pem",
  }

  concat::fragment { 'puppet-server-cert':
    target => '/etc/ssl/private/puppet-server.crt',
    order  => '20',
    source => "/etc/puppetlabs/puppet/ssl/certs/${::fqdn}.pem",
  }

}
