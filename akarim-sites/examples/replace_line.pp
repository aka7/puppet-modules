$files = {
  'allowuser' => { path => '/tmp/sshd_config', line => 'AllowGroups testgroup', match => "AllowGroups.*$" },
  'allowgroup' => { path => '/tmp/sshd_config',line => 'AllowUsers testuser ', match => "AllowUsers.*$" },
}
class { sites::replace_line: file_list => $files }
