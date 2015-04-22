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
  $version,
  $package,
  $provider,
  $dependencies,
  $conf,
  $hiera,
  $autosign,
  $repo_manage,
  $repo_location,
  $repo_release,
  $repo_repos,
  $repo_key,
  $repo_key_source,
) {

  contain ::puppet::repo
  contain ::puppet::config
  contain ::puppet::hiera
  contain ::puppet::install

}
