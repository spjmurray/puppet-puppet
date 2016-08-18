# == Class: puppet::config
#
# Create the puppet configuration file.
#
class puppet::config {

  assert_private()

  if $::puppet::conf_merge {
    $_conf = lookup('puppet::conf', Hash[String, Hash[String, String]], 'deep')
  } else {
    $_conf = $::puppet::conf
  }

  if $_conf {

    file { '/etc/puppetlabs/puppet/puppet.conf':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('puppet/puppet.conf.erb'),
    }

  }

}
