# nfs

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with nfs](#setup)
    * [What nfs affects](#what-nfs-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with nfs](#beginning-with-nfs)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview
NFS module, manages nfs shares.
On solaris, share zfs mounts as nfs share.

## Module Description
NFS module, manages nfs shares.
On solaris, it's posisble use this share zfs mounts as nfs share.


## Setup

### What nfs affects

### Setup Requirements **OPTIONAL**


### Beginning with nfs

## Usage

## class: nfs::sharezfs_mount

share multiple zfs shares

### Parameters

[*path*]

 Identify a path for your NFS share that must exist within the file system or directory to be shared. 

[*zfspool*]

 zfs pool the path is on. Must exist within the system 

[*ensure*]

 present or absent
 Default: present

[*root_clients*]

 Identifies a root user from a specified host or list of hosts have root access. By default, no host has root access.

[*rw_clients*]

 List of read/write clients. You can also specify a colon-separated list that includes hostnames, IP addresses, or a netgroup.

[*ro_clients*]

 List of read only clients. You can also specify a colon-separated list that includes hostnames, IP addresses, or a netgroup.

[*security_mode*]

 Identifies a NFS server security mode, such as sys, dh, krb5, and so on.
 Default: sys

[*proto*]

 Identify the protocol as NFS or SMB.
  Default: nfs

### Examples
````
 $mount_list = {
 'data_backups_foo' => { 
                path          => "/data/foo",
                rw_clients    => "@10.234.4.72:@10.234.22.33",
                ro_clients    => "@10.234.4.71",
                zfspool       => "datapool",
        },
 }
 class { nfs::sharezfs_mount: zfs_mounts => $mount_list }
````


### Foreman way

in smartclass param, zfs_mount, define parameters like so,

````
data_backups_foo:
  path: "/data/foo"
  rw_clients:'@10.234.4.72:@10.234.22.33'
  ro_clients:'@10.234.4.71'
  zfspool: 'datapool'
````
This will create and share /data/foo as nfs shre,  giving access to clients, 10.234.4.72 and 10.234.22.33 for read write, and readonly access to client 10.234.4.71.

NOTE: zfs datapool/foo must be created seperately. you can use zfs puppet resource type to do this. I've ommited this on purpose. I don't want this to be managed in foreman to aviod the risk of someone adding ensure absent.


## class: nfs::mount_nfs

mount mutiple nfs mounts

### Parameters
 [*server*]

 nfs server address

 [*share*]

 share on remote server

 [*mountpoint*]

 where to mount in local file system

 [*remounts*]

 whether to remount if unmounted
 default true

 [*atboot*]

 enable at boot
 default true

 [*client_options*]

 nfs client mount options, default vers=4 

### examples

````
 $mount_list = {
   'my test share' => { 
                share        => "/data/backup",
                mountpoint   => "/mnt/tmp",
                server       => "10.10.10.10",
        },
 }
 class { nfs::mount_nfs: nfs_mounts => $mount_list }
````

#### Foreman way
smartclass param nfs_mounts, define mount points like so.

````
mytestshare:
  share: '/data/backup'
  mountpoint: '/mnt/tmp/'
  server: 10.10.10.10

````

Will mount 10.10.10.10:/data/backup to /mnt/tmp as nfs ver4

## Reference

some of the code in this module  been extracted from vairous places on the internet.

## Limitations
class: nfs::sharezfs_mount solaris 10 and 11 only.

class: nfs::mount_nfs, supports redhat,debian, solaris and suse


## Development

## Release Notes/Contributors/Etc **Optional**
