# Install Flask v2.1.0 package
package { 'flask':
    ensure   => '2.1.0',
    name     => 'flask=2.1.0',
    provider => 'pip3',
}