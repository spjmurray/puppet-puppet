# == Class: puppet::config
#
# Create the puppet configuration file.
#
class puppet::config {

  assert_private()

  if $::puppet::conf_merge {
    $_conf = lookup('puppet::conf', Puppet::Conf, 'deep')
  } else {
    $_conf = $::puppet::conf
  }

  if !empty($_conf) {

    file { '/etc/puppetlabs/puppet/puppet.conf':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('puppet/puppet.conf.erb'),
    }

  }

}
