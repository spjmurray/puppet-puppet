# == Class: puppet::master
#
# Installs the base puppet master packages
#
class puppet::master {

  assert_private()

  include ::puppet

  $ssldir = puppet_ssldir()

  package { 'puppetmaster-common':
    ensure   => $puppet::version,
    provider => $puppet::provider,
  } ->

  # TODO: This step should be conditional
  exec { 'create ca':
    command => "puppet cert generate ${::fqdn}",
    creates => "${ssldir}/certs/${::fqdn}.pem",
  }

  file { '/etc/puppet/autosign.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    content => template('puppet/autosign.conf.erb'),
  }

  # By depending on the base puppet class you are guaranteed that the repos
  # have been configured
  Class['::puppet'] -> Class['::puppet::master']

}
