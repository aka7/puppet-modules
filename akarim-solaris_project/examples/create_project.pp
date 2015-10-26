$proj_list = {
  'user.admin' => { 
		projid  => 100,
		name    => "user.admin",
		comment => "admin project settings",
		attribs => ["project.max-sem-nsems=(priv,128,deny)","project.max-sem-ids=(priv,100,deny)"]
	},
}
class { solaris_project::create_project: project_list => $proj_list }
