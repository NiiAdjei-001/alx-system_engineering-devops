# Create a file
file { '/etc/ssh/ssh_config':
  ensure  => present,
  mode    => '0600',
  content => "HOST 18.204.8.229
    HostName 18.204.8.229
    User ubuntu
    PasswordAuthentication no
    IdentityFile ~/.ssh/school\n"
}
