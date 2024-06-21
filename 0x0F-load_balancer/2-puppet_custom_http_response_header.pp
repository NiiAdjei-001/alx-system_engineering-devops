# Install and Configure Nginx
package { 'nginx':
  ensure => installed,
}

service { 'nginx':
  ensure  => true,
  enable  => true,
  require => Package['nginx'],
}

file { '/var/www/html':
  ensure  => present,
  require => Package['nginx'],
}

file { '/var/www/html/index.html':
  ensure  => present,
  content => 'Hello World!',
  require => Package['nginx'],
}

file { '/var/www/html/404.html':
  ensure  => present,
  content => "Ceci n'est pas une page",
  require => Package['nginx'],
}

file { '/var/www/html/redirect_me.html':
  ensure  => present,
  content => 'Moved Permanently',
  require => Package['nginx'],
}

file { '/etc/nginx/nginx.conf':
  ensure  => present,
  require => Package['nginx'],
  notify  => Service['nginx'],
}

file { '/etc/nginx/sites-available/default':
  ensure  => present,
  content => "
#Default Server Configuration
server {
  listen 80 default_server;
  listen [::]:80 default_server;

  root /var/www/html;

  index index.html index.htm index.nginx-debian.html;

  add_header X-Served-By \$hostname;

  server_name _;

  location /redirect_me {
    return 301 /redirect_me;
  }

  error_page 404 /404.html;
 
  location = /404.html {
    internal;
  }

  location = / {
    try_files \$uri \$uri/ =404;
  }
}
",
  require => Package['nginx'],
  notify  => Service['nginx'],
}
