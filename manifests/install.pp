# == Class: puppet::install
#
# Installs the base puppet packages
#
class puppet::install {

  package { 'puppet-agent':
    ensure   => $puppet::version,
  }

  # Ensure repos are installed before installing the base packages
  Class['::puppet::repo'] -> Class['::puppet::install']

}
