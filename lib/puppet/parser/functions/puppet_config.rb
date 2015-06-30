# Derive the ssl directory from the global configuration hash
module Puppet::Parser::Functions
  newfunction(:puppet_config, :type => :rvalue) do |args|
    section = args[0]
    setting = args[1]
    default = args[2]
    config = lookupvar('::puppet::conf')
    config[section] && config[section][setting] || default
  end
end
