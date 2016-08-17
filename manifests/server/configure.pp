# == Class: puppet::server::configure
#
# Configure puppetserver
#
class puppet::server::configure {

  $_ssl = $::puppet::server::ssl
  $_port = $::puppet::server::port
  $_autosign = $::puppet::server::autosign

  file { '/etc/puppetlabs/puppetserver/conf.d/puppetserver.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('puppet/puppetserver.conf.erb'),
  }

  file { '/etc/puppetlabs/puppetserver/conf.d/webserver.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('puppet/webserver.conf.erb'),
  }

  file { '/etc/puppetlabs/puppetserver/conf.d/auth.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('puppet/auth.conf.erb'),
  }

  if $puppet::server::autosign {
    file { '/etc/puppetlabs/puppet/autosign.conf':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      content => template('puppet/autosign.conf.erb'),
    }
  }

  if $::puppet::server::gems {
    $::puppet::server::gems.each |$gem| {
      exec { "/opt/puppetlabs/server/bin/puppetserver gem install ${gem}":
        unless => "/opt/puppetlabs/server/bin/puppetserver gem list ^${gem}$ | grep ${gem}",
      }
    }
  }

}
