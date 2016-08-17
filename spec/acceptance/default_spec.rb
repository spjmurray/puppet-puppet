require 'spec_helper_acceptance'

describe 'puppet' do
  context 'stand alone server' do
    it 'provisions with no errors' do
      hiera = <<-EOS
      puppet::server::gems:
        - 'deep_merge'
        - 'hiera-eyaml'
      EOS

      create_remote_file(default, '/etc/puppetlabs/code/environments/production/hieradata/common.yaml', hiera)

      pp = <<-EOS
        Exec { path => '/bin:/usr/bin:/sbin:/usr/sbin' }

        include ::puppet
        include ::puppet::server
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    it 'allows certificate generation' do
      shell('puppet cert generate `hostname -f`', :acceptable_exit_codes => 0)
    end

    it 'allows agent operation' do
      shell('puppet agent --no-daemonize --onetime --test', :acceptable_exit_codes => 0)
    end
  end

  context 'server with haproxy SSL offload' do
    it 'provisions with no errors' do
      hiera = <<-EOS
      puppet::server::ssl: false
      puppet::server::port: '18140'
      puppet::server::haproxy::server_port: '18140'
      EOS

      create_remote_file(default, '/etc/puppetlabs/code/environments/production/hieradata/common.yaml', hiera)

      pp = <<-EOS
        Exec { path => '/bin:/usr/bin:/sbin:/usr/sbin' }

        include ::puppet
        include ::puppet::server
        include ::puppet::server::haproxy
      EOS

      # Check for clean provisioning and idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    it 'allows agent operation' do
      shell('puppet agent --no-daemonize --onetime --test', :acceptable_exit_codes => 0)
    end
  end
end
