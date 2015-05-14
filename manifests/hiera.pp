# == Class: puppet::hiera
#
# Manages the hiera configuration
#
class puppet::hiera {

  assert_private()

  file { '/etc/puppet/hiera.yaml':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => generate_hiera($puppet::hiera),
  }

}
