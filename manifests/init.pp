# == Class: puppet
#
class puppet {

  contain ::puppet::repo
  contain ::puppet::config

  Class['::puppet::repo'] ->
  Class['::puppet::config']

}
