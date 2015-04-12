# == Class: puppet::agent::cron
#
# Create a cron service entry to trigger a puppet run
#
# === Parameters
#
# [*runinterval*]
#   Integer to determine how often puppet runs in minutes. Currently
#   this works for periods shorter than an hour.  Run times are
#   randomized based on MAC address to load balance
#
class puppet::agent::cron (
  $runiterval = 30,
) {

  include ::puppet

  cron { 'puppet-agent':
    command => 'puppet agent --onetime --no-daemonize',
    user    => 'root',
    minute  => interval_to_minute($runiterval),
  }

  Class['puppet'] -> Class['puppet::agent::cron']

}
