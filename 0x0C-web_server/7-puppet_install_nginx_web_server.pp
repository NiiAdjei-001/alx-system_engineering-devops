#
Exec { path => '/usr/local/bin/:/bin/'}
File {
  ensure => present,
  group  => 'www-data',
  mode   => '0775'
}

# Update libraries
exec { 'update_lib_repo':
  command => 'apt-get update -y && apt-get install nginx -y',
}

# Install Nginx Web Server
package { 'nginx':
  ensure  => 'installed',
  require => Exec['update_lib_repo']
}

# Setup uncomplicate firewall(ufw) features
exec { 'setup_ufw':
  command => 'ufw allow ssh && ufw allow "Nginx Full" && ufw --force enable',
  unless  => 'ufw status | grep -q "Status: active"',
  require => Package['nginx'],
}

# Setup Nginx Configuration File
file { '/etc/nginx/sites-available/default':
  content => "server {
    listen 80 default_server;
    listen [::] default_server;

    root /var/www/html/;
    index index.html;

    server_name _;

    error_page 404 /404.html;
    location /404.html {
      internal;
    }

    location / {
      try_files \$uri \$uri/ =404;
    }

    location /redirect_me {
      return 301 /redirect_me.html;
    }
  }",
  backup  => '.original'
}

# Setup default page
file { '/var/www/html/index.html':
  content => 'Hello World!',
}

# Setup 404 page
file { '/var/www/html/404.html':
  content => "Ceci n'est pas une page",
}

# Setup redirect_me page
file { '/var/www/html/redirect_me.html':
  content => '301 Moved Permanently',
}

