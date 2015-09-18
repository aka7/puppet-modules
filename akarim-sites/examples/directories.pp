$dirs = {
  '/opt/tmp'   => { owner => 'root' },
  '/opt/bin/test.txt'  => { owner => 'root',
                             ensure =>  'present'
                           },
}
class { sites::directories: directory_list => $dirs }
