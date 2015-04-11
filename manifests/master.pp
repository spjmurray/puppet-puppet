# == Class: puppet::master
#
# Installs the base puppet master packages
#
class puppet::master {

  private()

  include ::puppet

  $ssldir = puppet_ssldir()

  package { 'puppetmaster-common':
    ensure => installed,
  } ->

  exec { 'create ca':
    command => "puppet cert generate ${::fqdn}",
    creates => "${ssldir}/certs/${::fqdn}.pem",
  }

  Class['::puppet'] -> Class['::puppet::master']

}
