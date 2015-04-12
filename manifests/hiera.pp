# == Class: puppet::hiera
#
# Manages the hiera configuration
#
class puppet::hiera {

  private()

  file { '/etc/puppet/hiera.yaml':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('puppet/hiera.yaml.erb'),
  }

}
