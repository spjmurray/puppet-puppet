# == Class: puppet
#
# Performs common puppet setup functionality.  Called from
# puppet::agent and puppet::master
#
class puppet {

  assert_private()

  contain ::puppet::repo
  contain ::puppet::config

}
