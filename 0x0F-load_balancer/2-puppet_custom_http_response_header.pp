# Install and Configure Nginx Web Server
$package_name = 'nginx'
$service_name = 'nginx'
$webserver_config_file = '/etc/nginx/sites-available/default'
$config_template = "#Default Server Configuration
server {
	listen 80 default_server;
	listen [::]:80 default_server;

	root /var/www/html;

	index index.html index.htm index.nginx-debian.html;

	add_header X-served-By \$hostname;

	server_name _;

	location = / {
		try_files \$uri \$uri/ =200;
	}
  
  error_page 301 /custom_301.html;
	location = /redirect_me {
		return 301 /custom_301.html;
	}

	error_page 404 /custom_404.html; 
	location /custom_404.html {
		internal;
	}
}
"

package { $package_name:
	ensure => installed,
}

service { $service_name:
	ensure     => running,
	enable     => true,
	hasrestart => true,
	require    => Package[$package_name],
}

file { $webserver_config_file:
	ensure  => present,
	content => $config_template,
	require => Package[$package_name],
	notify  => Service[$service_name],
}

file { '/var/www/html':
	ensure  => 'directory',
  recurse => true,
}

file { '/var/www/html/index.html':
	ensure  => 'file',
	content => 'Hello World!',
	require => File['/var/www/html']
}

file { '/var/www/html/custom_301.html':
	ensure  => 'file',
	content => '301 Moved Permanently', 
	require => File['/var/www/html'],
}

file { '/var/www/html/custom_404.html':
	ensure  => 'file',
	content => "Ceci n'est pas une page",
	require => File['/var/www/html'],
}
