# == Class: puppet::agent
#
class puppet::agent (
  $ensure = 'installed',
  $provider = 'apt',
) {

  include ::puppet

  package { 'puppet-common':
    ensure   => $ensure,
    provider => $provider,
  }

  Class['::puppet'] -> Class['::puppet::agent']

}
