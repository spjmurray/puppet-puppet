# == Class: puppet::config
#
# Create the puppet configuration file.
#
class puppet::config {

  assert_private()

  if $::puppet::conf_merge {
    $_conf = hiera_hash('puppet::conf')
  } else {
    $_conf = $::puppet::conf
  }

  file { '/etc/puppet':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/etc/puppet/puppet.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('puppet/puppet.conf.erb'),
  }

}
