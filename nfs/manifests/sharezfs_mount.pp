# == Class: nfs::sharezfs_mount
#
# Full description of class here.
# Share mutiple zfs shares
#
# === Parameters
#[*path*]
#
# Identify a path for your NFS share that must exist within the file system or directory to be shared. 
#
#[*zfspool*]
#
# zfs pool the path is on. Must exist within the system 
#
#[*ensure*]
#
# present or absent
# default: present
#
#[*root_clients*]
#
# Identifies a root user from a specified host or list of hosts have root access. By default, no host has root access.
#
#[*rw_clients*]
#
# List of read/write clients. You can also specify a colon-separated list that includes hostnames, IP addresses, or a netgroup.
#
#[*ro_clients*]
#
# List of read only clients. You can also specify a colon-separated list that includes hostnames, IP addresses, or a netgroup.
#
#[*security_mode*]
#
# Identifies a NFS server security mode, such as sys, dh, krb5, and so on.
# Default: sys
#
#[*proto*]
#
# Identify the protocol as NFS or SMB.
#  Default: nfs
#
# Document parameters here.
#
# === Examples
# $mount_list = {
# 'data_backups_netcool' => { 
#                path          => "/data/netcool",
#                rw_clients    => "@10.234.4.72:@10.234.22.33",
#                ro_clients    => "@10.234.4.71",
#                zfspool       => "datapool",
#        },
# }
# class { nfs::sharezfs_mount: zfs_mounts => $mount_list }
# === Authors
#
# Author Name <abdul.karim@sky.uk>
#
# === Copyright
#
class nfs::sharezfs_mount ($zfs_mounts) {
        create_resources('nfs::zfs_share', $zfs_mounts)
}
