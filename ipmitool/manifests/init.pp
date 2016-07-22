# == Class: ipmitool
#
# Full description of class ipmitool here.
#
# === Parameters
#
# Document parameters here.
#
# Module to install ipmitool tools on all physical hosts
# Tested only on RHEL systems
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { ipmitool:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class ipmitool {
  if $::is_virtual == false and $::operatingsystem == 'RedHat' {
    package {'OpenIPMI':
      ensure => installed
    }
    package {'ipmitool':
      ensure  => installed,
      require => Package['OpenIPMI']

    }
    service {'ipmievd':
      ensure  => running,
      enable  => true,
      require => Service['ipmi']
    }
    service {'ipmi':
      ensure  => running,
      enable  => true,
      require => Package['OpenIPMI']
    }
  }else{
    warning('This ipmitool module is only supported on redhat physical hosts')
  }
}
