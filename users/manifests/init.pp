# == Define: Users
#
# A defined type for managing user accounts
# Features:
#   * Account creation w/ UID control
#   * Setting the login shell
#   * Group creation w/ GID control (optional)
#   * Home directory creation ( and optionally management via /etc/skel )
#   * Support for system users/groups
#   * SSH key management (optional)
#
# === Parameters
#
# [*username*]
#   hash of usernames to realize, from vituallist 
#
#
# === Examples
#
#
# === Authors
#
# abdul.karim <abdul.karim@sky.uk>
#
# === Copyright
# 
# Copyright 2015 Sky Network Services, unless otherwise noted
#
class users($usernames){
  users::accounts {'user_list':
    username => $usernames
  }
}
