# == Define: users
#
# [*username*]
#   The hash of usernames to be realized.
#   Defaults to the title of the account resource.
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
define users::accounts(
  $username = [],
) {
  realize Users::Virtual::Account[$username]
}
