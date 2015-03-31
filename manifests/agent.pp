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
# === Notes
#
# * By default puppet::agent only installs puppet-common to allow the use
#   of agent and apply commands.  Triggers can be provided by external cron
#   jobs for asynchronous provisioning or mcollective for external synchronous
#   provisioning
#
class puppet::agent (
  $ensure   = 'installed',
  $provider = 'apt',
) {

  include ::puppet

  package { 'puppet-common':
    ensure   => $ensure,
    provider => $provider,
  }

  Class['::puppet'] -> Class['::puppet::agent']

}
