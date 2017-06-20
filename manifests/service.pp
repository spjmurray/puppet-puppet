# == Class: puppet::service
#
# Manages the puppet service
#
class puppet::service {

  case $::puppet::service_type {

    'cron': {
      cron { 'puppet-agent':
        command => '/opt/puppetlabs/bin/puppet agent --onetime --no-daemonize',
        user    => 'root',
        minute  => interval_to_minute($::puppet::service_iterval),
      }
    }

    'daemon': {
      service { 'puppet':
        ensure => running,
        enable => true,
      }
    }

    default: {
    }
  }


}
