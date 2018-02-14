# == Class: alerta
#
# basic module to setup alerta
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
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
#  class { 'alerta':
#  }
#
# === Authors
#
# Author Name <Abdul Karim>
#
# === Copyright
#
# Copyright 2018 Your name here, unless otherwise noted.
#
class alerta {
  include pip
  package {'mongodb-org':
      ensure => installed
  }
  package {'python-pip':
      ensure => installed
  }
  package {'python-dev':
      ensure => installed
  }
  package {'nginx':
      ensure => installed
  }
  pip::install {'alerta-server': 
    require => Package['python-pip']
  }
  pip::install {'alerta': 
    require => Package['python-pip']
  }
  pip::install {'uwsgi':
    require => Package['python-pip'],
  }

  service {'nginx':
      ensure    => 'running',
      subscribe => File['/etc/nginx/sites-enabled/default'],
      require   => Package['nginx']
  }

  service {'mongodb':
      ensure    => 'running',
      enable    => true,
      path      => '/etc/systemd/system/mongodb.service',
      subscribe => File ['/etc/systemd/system/mongodb.service'],
      require   => Package['mongodb-org']
  }

  service {'uwsgi':
    ensure    => 'running',
    enable    => true,
    path      => '/etc/systemd/system/uwsgi.service',
    subscribe => File ['/etc/systemd/system/uwsgi.service']
  }

  file { '/etc/nginx/sites-enabled/default':
    ensure  => 'present',
    source  => 'puppet:///modules/alerta/etc/nginx/sites-enabled/default' ,
  }
  file { '/etc/systemd/system/mongodb.service':
    ensure  => 'present',
    source  => 'puppet:///modules/alerta/etc/systemd/system/mongodb.service' ,
    require => Package['mongodb-org']
  }
  file { '/var/www/wsgi.py':
    ensure  => 'present',
    source  => 'puppet:///modules/alerta/var/www/wsgi.py' ,
    notify  => Service['uwsgi'],
    require => [ Exec['install_webgui'], Package['nginx']]
  }
  file { '/etc/uwsgi.ini':
    ensure  => 'present',
    source  => 'puppet:///modules/alerta/etc/uwsgi.ini' ,
  }
  file { '/etc/systemd/system/uwsgi.service':
    ensure  => 'present',
    source  => 'puppet:///modules/alerta/etc/systemd/system/uwsgi.service' ,
    notify  => Service['uwsgi']
  }
  file { '/var/www/html/config.js':
    source  => 'puppet:///modules/alerta/var/www/html/config.js',
    notify  => [ Service['nginx'],Service['uwsgi'] ],
    require => [ Exec['install_webgui'], Package['nginx']]
  }

  exec {'download_webgui':
    cwd     => '/var/tmp',
    command => 'wget -q -O - https://github.com/alerta/angular-alerta-webui/tarball/master | sudo tar zxf -',
    path    => ['/usr/bin','/bin','/sbin',],
    creates => '/var/www/html/js/app.js',
    before  => Exec['install_webgui'],
  }
  exec {'install_webgui':
    command => 'mv /var/tmp/alerta*/app/* /var/www/html',
    cwd     => '/var/tmp',
    creates => '/var/www/html/js/app.js',
    path    => ['/usr/bin','/bin','/sbin',],
    require => Package['nginx']
  }
}
