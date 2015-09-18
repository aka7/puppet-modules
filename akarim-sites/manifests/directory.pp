# == Define: Directory
#
# Create directory
# Features:
#
# === Parameters
#
# [*ensure*]
#   Can be one of "present", absent, Directory, Link,
#   Defaults to Directory
#
# [*path*]
# directory path
# [*owner*]
#  owner, default root
# [*groupr*]
#  group, default root
# [*mode*]
#  permission, default 0755
#   
# [*target*]
#  target, for sym link
# [*content*]
#  content of a file
#
#
# === Examples
#
# === Authors
#
#
# === Copyright
#
#
define sites::directory(
  $path    = $title,
  $ensure  = 'directory',
  $group   = root,
  $owner   = root,
  $mode    = 0755,
  $target  = undef,
  $content = undef,
) {


 if $ensure == 'link'{
 	file {$title :
		path   => $path,
		ensure => $ensure,
		owner  => $owner,
		group  => $group,
		mode   => $mode,
		target => $target,
	}
	
 }elsif $ensure == 'present'{
	if $content == undef {
		warning ("Empty content, NOT CREATING EMPTY FILE")
	}else{
 		file {$title :
			path   => $path,
			ensure => $ensure,
			owner  => $owner,
			group  => $group,
			mode   => $mode,
			content => $content
		}
	}
  }else{
 	file {$title :
		path   => $path,
		ensure => $ensure,
		owner  => $owner,
		group  => $group,
		mode   => $mode,
	}
 }
}
