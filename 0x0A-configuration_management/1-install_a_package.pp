# Install Flask v2.1.0 package
package { 'python3'
    ensure  => installed,
}

package { 'python3-pip'
    ensure  => installed,
    require => ['python3'],
}

exec { 'install_flask':
    command => 'pip3 install flask==2.1.0',
    require => ['python3-pip']
}