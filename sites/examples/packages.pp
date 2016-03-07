$pkg = {
  'java' => { ensure => 'installed' },
}
class { 'sites::packages': package_list => $pkg }
