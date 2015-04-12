require 'spec_helper_acceptance'

describe 'puppet::master::apache' do
  context 'stand-alone' do
    it 'provisions with no errors' do
      pp = <<-EOS
        Exec { path => '/bin:/usr/bin:/sbin:/usr/sbin' }
        include puppet::master::apache
      EOS
      # Check for clean provisioning and idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
    it 'allows agent operation' do
      # Check puppet agent runs okay
      shell('puppet agent --no-daemonize --onetime --test', :acceptable_exit_codes => 0)
    end
  end
end
