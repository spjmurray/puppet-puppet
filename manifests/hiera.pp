# == Class: puppet::hiera
#
# Manages the hiera configuration
#
class puppet::hiera {

  assert_private()

  if $::puppet::hiera {

    file { '/etc/puppetlabs/puppet/hiera.yaml':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => $::puppet::hiera,
    }

  }

}
