# Derive the ssl directory from the global configuration hash
module Puppet::Parser::Functions
  newfunction(:puppet_ssldir) do |args|
    config = lookupvar('puppet::config::values')
    setting = config.select { |x| x == 'main/ssldir' }
    if setting.empty?
      '/etc/puppet/ssl'
    else
       setting['main/ssldir']['value']
    end
  end
end
