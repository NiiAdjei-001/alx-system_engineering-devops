# Execute a command to kill process with name killmenow
exec { 'execute kill command':
    command => 'pkill -9 "killmenow"',
    path    => ['/usr/bin/']
}