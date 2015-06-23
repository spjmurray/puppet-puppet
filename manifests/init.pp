# == Class: puppet
#
# Performs common puppet setup functionality.  Called implicitly from
# puppet::agent and puppet::master
#
# === Parameters
#
# [*version*]
#   Version of the packages to install
#
# [*package*]
#   Package to install e.g. puppet-common in apt is puppet in gem
#
# [*provider*]
#   Where to source the packages from
#
# [*path*]
#   Absolute path to the puppet binary for things like cron with
#   restricted $PATH
#
# [*dependencies*]
#   Additional package dependencies
#
# [*conf*]
#   Puppet configuration file contents
#
# [*hiera*]
#   Hiera configuration file contents
#
# [*autosign*]
#   Array of autosign.conf entries
#
# [*repo_manage*]
#   Whether to enable module control of the puppet apt repository
#
# [*repo_location*]
#   Where the repository resides
#
# [repo_*release*]
#   Release of the repository to use
#
# [*repo_repos*]
#   The repositories to enable
#
# [*repo_key*]
#   The GPG key fingerprint to accept
#
# [*repo_key_source*]
#   Where to source the GPG key from
#
# === Notes
#
# * Chances are you are defining hiera in hiera, and as such any variable
#   substitutions must be escaped.  To generate the correct output for
#   ```modules/%{calling_module}``` you will need to specify the hiera input
#   as ```modules/%%{}{calling_module}```
#
# * PuppetLabs only support LTS, so for releases like utopic you will need
#   to use the trusty release to get upstream packages
#
class puppet (
  # Version control
  $version = 'installed',
  $package = 'puppet-common',
  $provider = 'apt',
  $path = '/usr/bin/puppet',
  # Installation control
  $dependencies = [
    'ruby-shadow',
  ],
  # Configuration management
  $conf = {
    'main' => {
      'logdir' => '/var/lib/puppet',
      'vardir' => '/var/lib/puppet',
      'ssldir' => '/var/lib/puppet/ssl',
      'rundir' => '/var/run/puppet',
    },
    'agent' => {
      'server' => $::fqdn,
    },
  },
  # Hiera management
  $hiera = {
    'backends' => [
      'yaml',
    ],
    'yaml' => {
      'datadir' => '/var/lib/hiera',
    },
    'hierarchy' => [
      '"%{::hostname}"',
      '"%{::environment}"',
      'common',
    ],
  },
  # Autosign management
  $autosign_manage = true,
  $autosign = [],
  # Repository management
  $repo_manage = false,
  $repo_location = 'http://apt.puppetlabs.com',
  $repo_release = 'trusty',
  $repo_repos = 'main dependencies',
  $repo_key = '47B320EB4C7C375AA9DAE1A01054B7A24BD6EC30',
  $repo_key_source = 'https://apt.puppetlabs.com/keyring.gpg',
) {

  contain ::puppet::repo
  contain ::puppet::config
  contain ::puppet::hiera
  contain ::puppet::install

}
