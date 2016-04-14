# == Class: nfs::mount
#
# mount an remote NFS share
#
# === Parameters
#
# [*server*]
# nfs server address
#
# [*share*]
# share on remote server
# [*mountpoint*]
# where to mount in local file system
# [*remounts*]
# whether to remount if unmounted
# default true
# [*atboot*]
# enable at boot
# default true
# [*client_options*]
# nfs client mount options, default vers=4 
#
# === Authors
#
# Author Name <akarim786@gmail.com>
#
# === Copyright
#

define nfs::mount(
  $server,
  $share,
  $mountpoint,
  $ensure         = 'present',
  $client_options = 'vers=4',
  $remounts       = true,
  $atboot         = true,
){
  mount {"shared ${share} by ${server}":
    device   => "${server}:${share}",
    fstype   => 'nfs',
    name     => $mountpoint,
    options  => $client_options,
    remounts => $remounts,
    atboot   => $atboot,
  }
  case $ensure {
    'present': {
      exec {"create ${mountpoint} and parents":
        command => "mkdir -p ${mountpoint}",
        unless  => "test -d ${mountpoint}",
        path    => $::path
      }
      Mount["shared ${share} by ${server}"] {
        require => Exec["create ${mountpoint} and parents"],
        ensure  => mounted,
      }
    }

    'absent': {
      file { $mountpoint:
        ensure  => absent,
        require => Mount["shared ${share} by ${server}"],
      }
      Mount["shared ${share} by ${server}"] {
        ensure => absent,
      }
    }

    default: {
      fail('Ensure should be `present` or `absent`')
    }
  }
}
