# == Class: puppet::install
#
# Installs the base puppet packages
#
class puppet::install {

  package { $puppet::package:
    ensure   => $puppet::version,
    provider => $puppet::provider,
  }

  # Ensure repos are installed before installing the base packages
  Class['::puppet::repo'] -> Class['::puppet::install']

}
