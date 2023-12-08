# Install Flask v2.1.0 package
package { 'python3-pip':
    ensure   => 'installed'
    name     => 'python3-pip'
    provider => 'apt'
}

package { 'flask':
    ensure   => 'installed',
    name     => 'flask=2.1.0',
    provider => 'pip3',
    require  => Package['python3-pip']
}