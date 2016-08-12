require 'beaker-rspec'
require 'beaker/puppet_install_helper'

run_puppet_install_helper

RSpec.configure do |c|
  module_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.formatter = :documentation

  c.before :suite do
    hosts.each do |host|
      # Install this module for testing
      copy_module_to(host, :source => module_root, :module_name => 'puppet')

      # Install common master/agent deps
      on host, puppet('module', 'install', 'puppetlabs-apt'), { :acceptable_exit_codes => [0,1] }
      on host, puppet('module', 'install', 'puppetlabs-inifile'), { :acceptable_exit_codes => [0,1] }
      on host, puppet('module', 'install', 'puppetlabs-stdlib'), { :acceptable_exit_codes => [0,1] }

      # Install master only deps
      on host, puppet('module', 'install', 'puppetlabs-apache'), { :acceptable_exit_codes => [0,1] }
      on host, puppet('module', 'install', 'puppetlabs-concat'), { :acceptable_exit_codes => [0,1] }
    end
  end
end
