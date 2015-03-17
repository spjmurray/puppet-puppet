# == Class: puppet::config
#
# Create the puppet configuration file.  Uses a hiera hash
# lookup so you can have common components and role/host
# specific configuration in separate hiera files
#
# === Parameters
#
# [*values*]
#   Hash of section/setting keys and associated values
#   passed to the puppet_config type
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
