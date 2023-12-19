# Create a file
file { '/etc/ssh/ssh_config':
  ensure  => present,
  mode    => '0600',
  content => "HOST 100.26.235.117
    HostName 100.26.235.117
    User ubuntu
    PasswordAuthentication no
    IdentityFile ~/.ssh/school\n"
}
