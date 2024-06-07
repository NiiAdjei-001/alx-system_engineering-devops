#-----------------------------------------------------
# Install and Configure New Nginx Server on Ubuntu OS
#-----------------------------------------------------

# Install Nginx package
package { 'nginx':
  ensure  => 'installed',
}

# Run Nginx service
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx']
}

# Manage Nginx Configuration
file { '/etc/nginx/nginx.conf':
  ensure  => 'file',
  require => Package['nginx'],
  notify  => Service['nginx']
}

# Manage Default Server Configuration
file { '/etc/nginx/sites-available/default':
  ensure  => 'present',
  content => "#Default Server Configuration
server {
  listen 80 default_server;
  listen [::]:80 default_server;

  root /var/www/html;

  index index.html index.htm index.nginx-debian.html;

  add_header X-Served-By \$hostname;

  server_name _;

  location = /redirect_me {
    return 301 /redirect_me.html;
  }

  error_page 404 /404.html;
  location = /404.html {
    internal;
    default_type text/html;
    return 404 'C\'est ne pas ici';
  }

  location = / {
    try_files \$uri \$uri/ =404;
  }

}"
  require => Package['nginx'],
  notify  => Service['nginx'],
}

#-----------------------------------------------------
# Prepare Web pages
#-----------------------------------------------------

file { '/var/www/html':
  ensure  =>  'directory',
}

file { '/var/www/html/index.html':
  ensure  => 'present',
  content => 'Hello World!',
  require => FILE['var/www/html']
}

file { '/var/www/html/404.html':
  ensure  => 'present',
  content => "Ceci n'est pas une page",
  require => FILE['var/www/html']
}

file { '/var/www/html/redirect_me.html':
  ensure  => 'present',
  content => '301 Moved Permanently',
  require => FILE['var/www/html'],
}
