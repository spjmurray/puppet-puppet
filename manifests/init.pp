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
# [*conf*]
#   Puppet configuration file contents
#
# [*conf_merge*]
#   Whether to merge configuration hash with hiera
#
# [*hiera*]
#   Hiera configuration file contents
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
# [*service_type*]
#   Which puppet agent service type to use
#
# [*service_iterval*]
#   How often to run the agent
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
  String $version = 'installed',
  Optional[Hash[String, Hash[String, String]]] $conf = undef,
  Boolean $conf_merge = false,
  Optional[Hash] $hiera = undef,
  Boolean $repo_manage = false,
  String $repo_location = 'http://apt.puppet.com',
  String $repo_release = $::lsbdistcodename,
  String $repo_repos = 'PC1',
  String $repo_key = '47B320EB4C7C375AA9DAE1A01054B7A24BD6EC30',
  String $repo_key_source = 'https://apt.puppet.com/keyring.gpg',
  Optional[Enum['cron']] $service_type = undef,
  Integer $service_iterval = 30,
) {

  contain ::puppet::repo
  contain ::puppet::install
  contain ::puppet::config
  contain ::puppet::hiera
  contain ::puppet::service

  Class['::puppet::repo'] ->
  Class['::puppet::install'] ->
  Class['::puppet::config'] ->
  Class['::puppet::hiera'] ->
  Class['::puppet::service']

}
