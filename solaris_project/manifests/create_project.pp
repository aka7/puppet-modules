# == Class: solaris_project::create_project
#create file with content on a give list of files
#
class solaris_project::create_project($project_list){
  create_resources('solaris_project::project', $project_list)
}
