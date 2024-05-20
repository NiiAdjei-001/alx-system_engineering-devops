
# Install Nginx Web Server
package { 'nginx':
  ensure => 'installed',
}

# Setup uncomplicate firewall(ufw) features
Exec { path => '/usr/local/bin/:/bin/'}

exec { 'setup_ufw':
  command  => 'ufw allow ssh';
  command  => 'ufw allow \'Nginx Full\'';
  command  => 'ufw enable';
  require  => Package['nginx'],
}

# Define common file configurations
File {
  ensure => 'present',
  group  => 'ubuntu',
  mode   => '0775'
}

# Setup Nginx Configuration File
file { '/etc/nginx/sites-available/default':
  content => 'server {
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
	}',
  backup  => '.original'
}

# Setup default page
file { '/var/www/html/index.html':
  content => 'Hello World!',
}

# Setup 404 page
file { '/var/www/html/404.html':
  content => 'Ceci n\'est pas une page',
}

# Setup redirect_me page
file { '/var/www/html/redirect_me.html':
  content => '301 Moved Permanently',
}

