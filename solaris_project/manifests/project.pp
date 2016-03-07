
# == Class: solaris_project::project
# Manage solaris project
# /etc/project
# Features:
#
# === Parameters
#
# [*ensure*]
#   Can be one of "present", absent.
#   Defaults to present.
#
# [*project_name*]
#   The name of the project
#
# [*projid*]
#   The id of the project
#
# [*comment*]
#  Add a project comment, short description
#
# [*users*]
# Specify a  user  list  for  the project, comma separated
#
# [*groups*]
#  Specify a group  list  for  the  project, comma separated
#
# [*attribs*]
# Specify an attribute  list  for the    project, array list
#
# === Examples
# $proj_list = {
#  'user.admin' => { 
#                projid  => 100,
#                name    => "user.admin",
#                comment => "test proj",
#                attribs => ["project.max-sem-nsems=(priv,128,deny)","project.max-sem-ids=(priv,100,deny)"]
#        },
#}

# === Authors
# abdul.karim@sky.uk
#
# === Copyright
# SNS
#


define solaris_project::project(
  $project_name    = $title,
  $projid          = undef,
  $comment         = '',
  $users           = undef,
  $groups          = undef,
  $attribs         = [],
  $ensure          = 'present',

){
  if $::osfamily != 'Solaris' {
    err ('solaris_project module is only support on solaris OS')
  }else{
    sol_project { $title:
      ensure  => $ensure,
      name    => $project_name,
      users   => $users,
      groups  => $groups,
      comment => $comment,
      id      => $projid,
      attribs => $attribs,
    }
  }
}

