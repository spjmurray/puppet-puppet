Puppet::Functions.create_function('puppet::data') do
  def data()
    { 'puppet::version' => 'installed',
      'puppet::package' => 'puppet-common',
      'puppet::provider' => 'apt',
      'puppet::dependencies' => [
        'ruby-shadow',
      ],
      'puppet::conf' => {
        'main' => {
          'logdir' => '/var/lib/puppet',
          'vardir' => '/var/lib/puppet',
          'ssldir' => '/var/lib/puppet/ssl',
          'rundir' => '/var/run/puppet',
        },
      },
      'puppet::hiera' => {
        'backends' => [
          'yaml',
        ],
        'yaml' => {
          'datadir' => '/var/lib/hiera',
        },
        'hierarchy' => [
          'common',
        ],
      },
      'puppet::autosign' => [],
      'puppet::repo_manage' => true,
      'puppet::repo_location' => 'http://apt.puppetlabs.com',
      'puppet::repo_release' => 'trusty',
      'puppet::repo_repos' => 'main dependencies',
      'puppet::repo_key' => '47B320EB4C7C375AA9DAE1A01054B7A24BD6EC30',
      'puppet::repo_key_source' => 'https://apt.puppetlabs.com/keyring.gpg',
    }
  end
end
