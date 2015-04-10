# == Class: puppet::master::webrick
#
# Installs the default puppet webrick server
#
class puppet::master::webrick {

  include ::puppet::master

  package { 'puppetmaster':
    ensure => installed,
  }

  Class['::puppet::master'] -> Class['::puppet::master::webrick']

}
