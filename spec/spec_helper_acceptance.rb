require 'beaker-rspec'

config = {
  'main' => {
    'logdir' => '/var/log/puppet',
    'vardir' => '/var/lib/puppet',
    'ssldir' => '/var/lib/puppet/ssl',
    'rundir' => '/var/run/puppet',
  },
}

# Install latest puppet from puppetlabs.com
on hosts, install_puppet
# Explicitly configure puppet to avoid warnings
configure_puppet(config)

RSpec.configure do |c|
  module_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.formatter = :documentation

  c.before :suite do
    # Install this module for testing
    puppet_module_install(:source => module_root, :module_name => 'puppet')
    # Install common master/agent deps
    on hosts, puppet('module', 'install', 'puppetlabs-apt'), { :acceptable_exit_codes => [0,1] }
    on hosts, puppet('module', 'install', 'puppetlabs-inifile'), { :acceptable_exit_codes => [0,1] }
    on hosts, puppet('module', 'install', 'puppetlabs-stdlib'), { :acceptable_exit_codes => [0,1] }
    # Install master only deps
    on master, puppet('module', 'install', 'puppetlabs-apache'), { :acceptable_exit_codes => [0,1] }
    on master, puppet('module', 'install', 'puppetlabs-concat'), { :acceptable_exit_codes => [0,1] }
    # Install hieradata
    scp_to(hosts, "#{module_root}/spec/fixtures/hiera.yaml", '/tmp/')
    scp_to(hosts, "#{module_root}/spec/fixtures/hieradata/", '/tmp/', )
  end
end
