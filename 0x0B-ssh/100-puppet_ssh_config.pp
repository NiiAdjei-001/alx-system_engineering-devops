# Create a file
file { '/etc/ssh/ssh_config':
  ensure  => present,
  mode    => '0600',
  content => "HOST 100.26.252.151
    HostName 100.26.252.151
    User ubuntu
    PasswordAuthentication no
    IdentityFile ~/.ssh/school\n"
}
