# == Class: puppet::master::apache
#
# Deploy a standalone puppet master with an apache ssl passenger
# frontend
#
class puppet::master::apache {

  include ::apache
  include ::apache::mod::passenger
  include ::puppet::master

  $ssldir = puppet_config('main', 'ssldir', '/etc/puppet/ssl')

  file { [
    '/etc/puppet/rack',
    '/etc/puppet/rack/public',
    '/etc/puppet/rack/tmp',
  ]:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  } ->

  file { '/etc/puppet/rack/config.ru':
    ensure => file,
    source => 'puppet:///modules/puppet/config.ru',
    owner  => 'puppet',
    group  => 'puppet',
    mode   => '0644',
  }

  $vhost_params_common = {
    'docroot'           => '/etc/puppet/rack/public/',
    'port'              => '8140',
    'rack_base_uris'    => '/',
    'directories'       => {
      'path'           => '/etc/puppet/rack/public/',
      'options'        => 'None',
      'allow_override' => 'None',
    },
  }

  if ::puppet::ssl {
    $vhost_params_ssl = {
      'ssl'               => true,
      'ssl_protocol'      => '-ALL +SSLv3 +TLSv1',
      'ssl_cipher'        => 'ALL:!ADH:RC4+RSA:+HIGH:+MEDIUM:-LOW:-SSLv2:-EXP',
      'ssl_cert'          => "${ssldir}/certs/${::fqdn}.pem",
      'ssl_key'           => "${ssldir}/private_keys/${::fqdn}.pem",
      'ssl_chain'         => "${ssldir}/certs/ca.pem",
      'ssl_ca'            => "${ssldir}/certs/ca.pem",
      'ssl_crl_check'     => 'chain',
      'ssl_crl'           => "${ssldir}/crl.pem",
      'ssl_verify_client' => 'optional',
      'ssl_verify_depth'  => '1',
      'ssl_options'       => '+StdEnvVars +ExportCertData',
      'request_headers'   => [
        'unset X-Forwarded-For',
        'set X-SSL-Subject %{SSL_CLIENT_S_DN}e',
        'set X-Client-DN %{SSL_CLIENT_S_DN}e',
        'set X-Client-Verify %{SSL_CLIENT_VERIFY}e',
      ],
    }
  } else {
    $vhost_params_ssl = {}
  }

  $vhost_params = merge($vhost_params_common, $vhost_params_ssl)

  create_resources('apache::vhost', { 'puppetmaster' => {} }, $vhost_params)

  File['/etc/puppet/rack/config.ru'] -> Apache::Vhost['puppetmaster']

  # Ensure the master and certificates are installed before starting the server
  Class['::puppet::master'] -> Class['::puppet::master::apache']

  # Notify apache to restart if the main or hiera configuration changes.
  # These files are read on restart only
  Class['::puppet'] ~> Class['::apache::service']

}
