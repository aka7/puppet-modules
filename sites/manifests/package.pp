# == Define: Packages
#
# A install list of packages
# Features:
#
# === Parameters
#
# [*ensure*]
#   Can be one of "present", absent, purged, held, latest.
#   Defaults to installed.
#
# [*name*]
#   The name of the package
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
define sites::package(
  $pkgname = $title, $ensure = 'installed',$source=undef
){
  Package {
    allow_virtual => false,
  }
  if $source != undef {
    package {
      $title:
      ensure => $ensure,
      name   => $pkgname,
      source => $source
    }
  }
  else {
    package {
      $title:
      ensure => $ensure,
      name   => $pkgname,
    }
  }
}
