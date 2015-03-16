Puppet::Type.newtype(:puppet_config) do
  ensurable
  newparam(:name, :namevar => true) do
    desc 'Section/setting in /etc/puppet/puppet.conf'
    newvalues(/\S+\/\S+/)
  end
  newproperty(:value) do
    desc 'The value of the setting being defined'
    munge do |v|
      v.to_s.strip
    end
  end
end
