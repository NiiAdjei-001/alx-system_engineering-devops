# Install Flask v2.1.0 package
$python_packages = ['python3', 'python3-pip']

exec { 'apt update':
    command => '\usr\bin\apt update'
}

package { $python_packages:
    ensure   => 'installed'
    provider => 'apt'
    require  => Exec['apt update']
}

package { 'flask':
    ensure   => '2.1.0',
    provider => 'pip3',
    require  => Package[$python_packages]
}