node default {
}
node 'srv1' {
        package { 'nginx' :
        ensure => installed,
        }
        file { '/etc/nginx/nginx.conf':
      ensure  => file,
      source  => 'puppet:///extra_files/nginx.conf-srv1',
      require => Package['nginx'],

    }
         service {'nginx':
        ensure => running,
        start   => '/usr/sbin/nginx -c /etc/nginx/nginx.conf',
        require => File['/etc/nginx/nginx.conf'],
        }
         package { 'php-fpm' :
        ensure => installed,
      require => Package['nginx'],
        }

         service {'php-fpm':
        ensure => running,
        start   => 'php-fpm',
      require => Package['php-fpm'],
        }

          package { 'php-mysql' :
        ensure => installed,
      require => Package['php-fpm'],
        }


        package { 'nfs-utils':
        ensure => installed,
        }
        package {'rpcbind':
        ensure => installed,
        }
        service {'rpcbind':
        ensure => running,
        start   => 'rpcbind; rpc.statd --no-notify',
        }
    mount { "/shared":
        device  => "192.168.10.100:/shared",
        fstype  => "nfs",
        ensure  => "mounted",
        options => "defaults",
        subscribe => Service['rpcbind'],
        }


          package { 'mariadb-server' :
        ensure => installed,
        }
          file { '/bin/master.sh':
      ensure  => file,
      source  => 'puppet:///extra_files/master.sh',
      require => Package['mariadb-server'],

    }
         file { '/etc/my.cnf':
      ensure  => file,
      source  => 'puppet:///extra_files/master_my.cnf',
      require => Package['mariadb-server'],

    }


         service {'master':
        start   => '/usr/bin/bash /bin/master.sh',
        require => File['/bin/master.sh'],
        }



}

