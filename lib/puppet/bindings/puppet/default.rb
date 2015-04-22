Puppet::Bindings.newbindings('puppet::default') do
  bind {
    name         'puppet'
    to           'function'
    in_multibind 'puppet::module_data'
  }
end
