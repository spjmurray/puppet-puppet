# == Class: puppet::server::service
#
# Manage puppetserver service
#
class puppet::server::service {

  service { 'puppetserver':
    ensure => running,
    enable => true,
  }

}
