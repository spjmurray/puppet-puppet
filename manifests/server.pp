# == Class: puppet::server
#
# Installs the base puppet master packages
#
# === Parameters
#
# [*ssl*]
#   Whether a master node should use SSL
#
# [*port*]
#   Which port to listen on
#
# [*gems*]
#   Gems to install in the server
#
# [*autosign*]
#   Array of autosign.conf entries
#
class puppet::server (
  Boolean $ssl = true,
  String $port = '8140',
  Optional[Array[String]] $gems = undef,
  Optional[Array[String]] $autosign = undef,
) {

  contain ::puppet::server::install
  contain ::puppet::server::configure
  contain ::puppet::server::service

  Class['::puppet'] ->
  Class['::puppet::server::install'] ->
  Class['::puppet::server::configure'] ~>
  Class['::puppet::server::service']

}
