# == Class: solaris_project
#
# Full description of class solaris_project  here.
# class to manage solaris project 
#
# === Parameters
# 
# [*ensure*]
#   Can be one of "present", absent.
#   Defaults to present.
#
# [*name*]
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
# Document parameters here.
#
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#
# $proj_list = {
#  'user.admin' => { 
#                projid  => 100,
#                name    => "user.admin",
#                comment => "test proj",
#                attribs => ["project.max-sem-nsems=(priv,128,deny)","project.max-sem-ids=(priv,100,deny)"]
#        },
#}
#class { solaris_project::create_project: project_list => $proj_list }
#
# === Authors
#
# Author Abdul Karim <abdul.karim@sky.uk>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class solaris_project {
}
