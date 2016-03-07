sol_project { 'user.admin':
  ensure  => 'present',
  users   => 'admin',
  groups  => 'other',
  comment => 'testing',
  id      => 200,
  attribs => ['project.max-sem-ids=(priv,100,deny)'],
}
