$users = {
  'user1' => { uid => 4647,
    gid => 4647,
    home_dir => '/home/user1',
    create_group => true,
  },
}
class { 'users::virtual::accounts': user_data => $users }
