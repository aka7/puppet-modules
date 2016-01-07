# == Define: group
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
define users::group(
  $groupnames = [],
) {
  realize Users::Virtual::Group[$groupnames]
}
