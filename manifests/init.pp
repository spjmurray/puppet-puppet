# == Class: puppet
#
# Performs common puppet setup functionality.  Called from
# puppet::agent and puppet::master
#
class puppet {

  private()

  contain ::puppet::repo
  contain ::puppet::config
  contain ::puppet::hiera

}
