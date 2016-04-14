# == Class: nfs::mount_nfs
#
#  create muttiple nfs mounts
#
# === Parameters
# [*nfs_mounts*]
# hash of all nfsmount needed
#
#
# === Examples
# $mount_list = {
#   'my test share' => { 
#                share        => "/data/backup",
#                mountpoint   => "/mnt/tmp",
#                server       => "10.x.x.x",
#        },
# }
# class { nfs::mount_nfs: nfs_mounts => $mount_list }
# === Authors
#
# Author Name <abdul.karim@sky.uk>
#
# === Copyright
#
class nfs::mount_nfs ($nfs_mounts) {
        create_resources('nfs::mount', $nfs_mounts)
}
