# == Class: puppet::agent
#
# Installs the base puppet agent packages
#
# === Parameters
#
# [*ensure*]
#   Version of the agent packages to install
#
# [*provider*]
#   Where to source the package from
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
