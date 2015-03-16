# == Class: puppet::master
#
class puppet::master {

  assert_private()

  package { 'puppetmaster-common':
    ensure => installed,
  } ->

  exec { 'create ca':
    command => "puppet cert generate ${::fqdn}",
    creates => "/var/lib/puppet/ssl/certs/${::fqdn}.pem",
  }

}
