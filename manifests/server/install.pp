# == Class: puppet::server::install
#
# Install puppetserver
#
class puppet::server::install {

  assert_private()

  package { 'puppetserver':
    ensure   => $puppet::version,
  }

}
