# == Define: groups
#
# [*username*]
#   The hash of groups to be realized.
#   Defaults to the title of the group resource.
#
# === Examples
#
# === Authors
#
# abdul.karim <abdul.karim@sky.uk>
#
# === Copyright
# 
# Copyright 2015 Sky Network Services, unless otherwise noted
#
class users::groups($grouplist){
  users::group{'grouplist':
    groupnames => $grouplist
  }
}
