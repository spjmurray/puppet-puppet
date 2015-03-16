# == Class: puppet::config
#
class puppet::config {

  assert_private()

  file { '/etc/puppet':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  # Todo: Data bindings don't support hash merging yet
  $values = hiera_hash('puppet::config::values')

  create_resources('puppet_config', $values)

  resources { 'puppet_config':
    purge => true,
  }

  File['/etc/puppet'] -> Puppet_config <||>

}
