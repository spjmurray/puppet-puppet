# == Class: puppet::repo
#
class puppet::repo (
  $manage  = false,
  $release = $::lsbcodename,
) {

  assert_private()

  if $manage {

    include ::apt

    apt::source { 'puppetlabs':
      location   => 'htttp://apt.puppetlabs.com',
      release    => $release,
      repos      => 'main dependencies',
      key        => '4BD6EC30',
      key_source => 'https://apt.puppetlabs.com/keyring.gpg',
    }

  }

}
