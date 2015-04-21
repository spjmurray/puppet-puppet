# == Class: puppet::install
#
# Installs the base puppet packages
#
class puppet::install {

  package { $puppet::package:
    ensure   => $puppet::version,
    provider => $puppet::provider,
  }

  # Installing via gem doesn't pull in shadow file manipulation hence
  # the user type doesn't work fully.  Install additional packages puppet
  # depends on here
  ensure_packages($puppet::dependencies)

  # Ensure repos are installed before installing the base packages
  Class['::puppet::repo'] -> Class['::puppet::install']

}
