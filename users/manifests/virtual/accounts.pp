# == Define: users::virtual::accounts
#
# A defined type for managing virtual user accounts
# Features:
#   * takes a hash of users and creates them
#
# === Parameters
#
# [*userdata*]
#   hash for accounts, see accounts.pp
#
# [*parent_home_dir*]
#   location of parent homedir path
#
#
# === Examples
#
#
# === Authors
#
# Abdul Karim <abdul.karim@sky.uk>
#
# === Copyright
#
# Copyright 2015 Sky Network Service, unless otherwise noted
#
class users::virtual::accounts($user_data,$parent_home_dir=['/export','/export/home']){
  $path=$parent_home_dir
  file {$path:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
  $default_path={
    require => File[$path]
  }
  create_resources('@users::virtual::account', $user_data,$default_path)
}
