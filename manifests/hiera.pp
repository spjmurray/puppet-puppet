# == Class: puppet::hiera
#
# Manages the hiera configuration
#
# === Parameters
#
# [*hierarchy*]
#   Ordered list of files to search for hiera variable matches
#
# === Notes
#
# * Chances are you are defining hiera in hiera, and as such any variable
#   substitutions must be escaped.  To generate the correct output for
#   ```modules/%{calling_module}``` you will need to specify the hiera input
#   as '''modules/%%{}{calling_module}```
#
class puppet::hiera (
  $hierarchy = [ 'common' ],
  $datadir   = '/var/lib/hiera',
) {

  private()

  file { '/etc/puppet/hiera.yaml':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('puppet/hiera.yaml.erb'),
  }

}
