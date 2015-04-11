# == Class: puppet::repo
#
# Optionally manages the puppet labs repository.  You may prefer to have a
# centralized database in hiera if multiple modules define this and manage
# from there, or you want to use pinning etc.
#
# === Parameters
#
# [*manage*]
#   Whether to enable module control of the puppet apt repository
#
# [*location*]
#   Where the repository resides
#
# [*release*]
#   Release of the repository to use
#
# [*repos*]
#   The repositories to enable
#
# [*key*]
#   The GPG key fingerprint to accept
#
# [*key_source*]
#   Where to source the GPG key from
#
# === Notes
#
# * PuppetLabs only support LTS, so for releases like utopic you will need
#   to use the trusty release to get upstream packages
#
class puppet::repo (
  $manage     = false,
  $location   = 'http://apt.puppetlabs.com',
  $release    = $::lsbcodename,
  $repos      = 'main dependencies',
  $key        = '47B320EB4C7C375AA9DAE1A01054B7A24BD6EC30',
  $key_source = 'https://apt.puppetlabs.com/keyring.gpg',
) {

  private()

  if $manage {

    include ::apt

    apt::source { 'puppetlabs':
      location   => $location,
      release    => $release,
      repos      => $repos,
      key        => $key,
      key_source => $key_source,
    }

  }

}
