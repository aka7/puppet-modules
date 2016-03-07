# == Define: file_line
#
# append a line at end of a file, using file_line function in stdlib
# Features:
#
# === Parameters
#
# [*ensure*]
#   Can be one of "present", absent.
#   Defaults to present 
#
# [*path*]
# file location
#   
#
# [*match*]
# regex match line
#
# === Examples
#
# === Authors
#
#
# === Copyright
#
#
define sites::file_line(
  $path  = $title,
  $line  = undef,
  $match = undef,
) {
  file_line { $title:
    path  => $path,
    line  => $line,
    match => $match,
  }
}
