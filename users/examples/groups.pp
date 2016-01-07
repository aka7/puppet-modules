$mygroups = {
  'sudo' => { gid => 4689, ensure => absent},
  'sudoadmin' => { gid => 4688, ensure =>absent }
}
class { 'users::virtual::groups': group_data => $mygroups }
$groups=['sudo']
class { 'users::groups': grouplist => $groups }
