# == Class: nfs::zfs_share
#
# Full description of class nfs::zfs_share here.
# class to create zfs shares on solaris 11 hosts
# 
#
# === Parameters
# [*path*]
#
# Identify a path for your NFS share that must exist within the file system or directory to be shared. 
#
# [*zfspool*]
#
# zfs pool the path is on. Must exist within the system 
#
# [*ensure*]
#
# present or absent
# default: present
#
# [*root_clients*]
#
# Identifies a root user from a specified host or list of hosts have root access. By default, no host has root access.
#
# [*rw_clients*]
#
# List of read/write clients. You can also specify a colon-separated list that includes hostnames, IP addresses, or a netgroup.
#
# [*ro_clients*]
#
# List of read only clients. You can also specify a colon-separated list that includes hostnames, IP addresses, or a netgroup.
#
# [*security_mode*]
#
# Identifies a NFS server security mode, such as sys, dh, krb5, and so on.
# Default: sys
#
# [*proto*]
#
# Identify the protocol as NFS or SMB.
#  Default: nfs
#
#
# Document parameters here.
define nfs::zfs_share(
  $path            = undef,
  $rw_clients      = '',
  $ro_clients      = '',
  $root_clients    = '',
  $proto           = 'nfs',
  $security_modes  = 'sys',
  $zfspool         = undef,
  $ensure          = 'present',

){
  if $::osfamily != 'Solaris' {
    err ('nfs::sharenfs is only support on solaris OS')
  }
  else{
    $tmp_name = regsubst($path,'/','_','G')
    $share_name = regsubst($tmp_name,'_','')
    sns_sharezfs { $share_name:
      ensure         => $ensure,
      share_name     => $share_name,
      path           => $path,
      zfspool        => $zfspool,
      root_clients   => $root_clients,
      security_modes => $security_modes,
      rw_clients     => $rw_clients,
      ro_clients     => $ro_clients,
      proto          => $proto
    }
  }
}
