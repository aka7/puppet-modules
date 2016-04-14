# == Class: users::virtual::groups
#
# A defined type for managing virtual groups
# Features:
#   * Group creation w/ GID control (optional)
#   * Support for system users/groups
#
# === Parameters
#
# [*ensure*]
#   The state at which to maintain the user account.
#   Can be one of "present" or "absent".
#   Defaults to present.
#
# [*groupname*]
#   The name of the group to be created.
#   Defaults to the title of the account resource.
#
# [*gid*]
#   The GID to set for the new group.
#   If set to undef, this will be auto-generated.
#   Defaults to undef.
# [*system*]
#   Whether the user is a "system" user or not.
#   Defaults to false.
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
class users::virtual::groups($group_data){
  create_resources('@users::virtual::group', $group_data)
}
