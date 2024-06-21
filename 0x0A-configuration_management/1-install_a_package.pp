# Install Flask
package { 'python3':
    ensure => '3.8.10',
}

package { 'python3-pip':
  ensure  => installed,
  require => Package['python3']
}

package { 'flask':
  ensure   => '2.1.0',
  provider => 'pip3',
  require  => Package['python3-pip'],
}

exec { 'uninstall_werkzeug':
  command => 'pip3 uninstall werkzeug',
  path    => '/usr/local/bin/:/bin/',
}

package { 'werkzeug':
  ensure    => '2.1.1',
  provider  => 'pip3',
  require   => Package['python3-pip'],
  subscribe => Exec['uninstall_werkzeug'],
}
