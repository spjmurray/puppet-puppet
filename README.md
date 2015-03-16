#Puppet

####Table Of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Usage](#usage)
4. [Dependencies](#dependencies)
5. [Limitations](#limitations)

##Overview

Deploys and configures Puppet

##Module Description

Lightweight puppet deployment.  Performs only the most rudimentary installation
tasks, configuration is up to the user.  Configuration is performed entriely in
hiera to cleanly separate code from data.  Puppet defaults are typically
sufficient to create a working setup.  The puppet::config class calls
hiera_hash under the covers so it is possible to define configuration in
common, role or node specific configuration files

##Usage

```puppet
include ::puppet::agent
include ::puppet::master::passenger
```

```yaml
---
# Install options
puppet::repo::manage: true
puppet::repo::release: 'trusty'

# puppet.conf
puppet::config::values:
  main/logdir:
    value: '/var/lib/puppet'
  main/rundir:
    value: '/var/run/puppet'
  main/ssldir:
    value: /var/lib/puppet/ssl'
```

##Dependencies

- http://github.com/puppetlabs/puppetlabs-apache
- http://github.com/puppetlabs/puppetlabs-inifile
- http://github.com/puppetlabs/puppetlabs-stdlib

##Limitations

