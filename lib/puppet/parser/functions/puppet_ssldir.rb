# Derive the ssl directory from the global configuration hash
module Puppet::Parser::Functions
  newfunction(:puppet_ssldir, :type => :rvalue) do |args|
    lookupvar('::puppet::conf')['main']['ssldir'] || '/etc/puppet/ssl'
  end
end
