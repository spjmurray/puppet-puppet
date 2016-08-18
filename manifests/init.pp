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
#   as ```modules/%{literal('%')}{calling_module}```
#
# * PuppetLabs only support LTS, so for releases like utopic you will need
#   to use the trusty release to get upstream packages
#
class puppet (
  String $version,
  Optional[Hash[String, Hash[String, String]]] $conf,
  Boolean $conf_merge,
  Optional[Hash] $hiera,
  Boolean $repo_manage,
  String $repo_location,
  String $repo_release,
  String $repo_repos,
  String $repo_key,
  String $repo_key_source,
  Optional[Enum['cron']] $service_type,
  Integer $service_iterval,
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
