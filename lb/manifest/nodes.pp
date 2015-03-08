node 'srv1' {


        file { '/shared' :
        ensure => directory,
        owner  => root,
        group  => root,
        mode   => 770,
        before => Package['rpcbind'],
        }

        package {'rpcbind' :
        ensure => installed,
        before => Package['nfs-utils'],
        }

        package { 'nfs-utils' :
        ensure => installed,
        before => Exec['run-nfs'],
        }

        exec { 'run-nfs' :
        command => 'rpcbind ; rpc.statd --no-notify',
        path => '/bin:/sbin:/usr/bin:/usr/sbin',
        before => Mount['/shared'],
        }

        mount { '/shared' :
        device  => "puppet:/shared",
        fstype  => "nfs",
        ensure  => "mounted",
        options => "defaults",
        before => Exec['picklock'],
        }

        exec { 'picklock' :
        command => 'grep `hostname` /etc/hosts > /shared/srv1.txt',
        path => '/bin:/sbin:/usr/bin:/usr/sbin',
        }

	  package { 'nginx' :
        ensure => installed,
        before => File['/etc/nginx/nginx.conf'],
        }

        file { '/etc/nginx/nginx.conf' :
        ensure  => file,
        source  => 'puppet:///extra_files/nginx.conf-srv1',
        before => Package['php-fpm'],
        }

        package { 'php-fpm' :
        ensure => installed,
        before => Package['php-mysql'],
        }

        package { 'php-mysql' :
        ensure => installed,
        before => Exec['php-fpm'],
        }

	exec { 'php-fpm' :
        command=> 'php-fpm &',
        path => '/bin:/sbin:/usr/bin:/usr/sbin',
        before => Exec['nginx'],
        }

        exec { 'nginx' :
        command  => '/usr/sbin/nginx -c /etc/nginx/nginx.conf &',
        path => '/bin:/sbin/usr/bin:/usr/sbin',
        before => Package['mariadb-server'],
        }

        package { 'mariadb-server' :
        ensure => installed,
        before => File['/etc/my.cnf'],
        }

        file { '/etc/my.cnf':
        ensure  => file,
        source  => 'puppet:///extra_files/master_my.cnf',
        before => File['/bin/master.sh'],
	}

	file { '/bin/master.sh':
        ensure  => file,
        source  => 'puppet:///extra_files/master.sh',
        owner  => root,
        group  => root,
        mode   => 777,
        before => File['/bin/master.sql'],
        }

        file { '/bin/master.sql':
        ensure  => file,
        source  => 'puppet:///extra_files/master.sql',
        owner  => root,
        group  => root,
        before => Exec['master.sh'],
        }

        exec { 'master.sh' :
        command => 'master.sh &',
        path => '/bin:/sbin:/usr/bin:/usr/sbin',
        }

}

node 'srv2' {

        file { '/shared' :
        ensure => directory,
        owner  => root,
        group  => root,
        mode   => 777,
        before => Package['rpcbind'],
        }

        package {'rpcbind' :
        ensure => installed,
        before => Package['nfs-utils'],
        }

        package { 'nfs-utils' :
        ensure => installed,
        before => Exec['run-nfs'],
        }

        exec { 'run-nfs' :
        command => 'rpcbind ; rpc.statd --no-notify',
        path => '/bin:/sbin:/usr/bin:/usr/sbin',
        before => Mount['/shared'],
        }

        mount { '/shared' :
        device  => "puppet:/shared",
        fstype  => "nfs",
        ensure  => "mounted",
        options => "defaults",
        before => Exec['picklock'],
        }

        exec { 'picklock' :
        command => 'grep `hostname` /etc/hosts > /shared/srv2.txt',
        path => '/bin:/sbin/usr/bin:/usr/sbin',
        before => Package['nginx'],
        }

        package { 'nginx' :
        ensure => installed,
        before => File['/etc/nginx/nginx.conf'],
        }
        file { '/etc/nginx/nginx.conf' :
        ensure  => file,
        source  => 'puppet:///extra_files/nginx.conf-srv2',
        before => Package['php-fpm'],
        }

        package { 'php-fpm' :
        ensure => installed,
        before => Package['php-mysql'],
        }

        package { 'php-mysql' :
        ensure => installed,
        before => Exec['php-fpm'],
        }

        exec { 'php-fpm' :
        command=> 'php-fpm &',
        path => '/bin:/sbin:/usr/bin:/usr/sbin',
        before => Exec['nginx'],
        }

        exec { 'nginx' :
        command  => '/usr/sbin/nginx -c /etc/nginx/nginx.conf &',
        path => '/bin:/sbin/usr/bin:/usr/sbin',
        before => Package['mariadb-server'],
        }

        package { 'mariadb-server' :
        ensure => installed,
        before => File['/bin/pre-slave.sh'],
        }

        file { '/bin/pre-slave.sh' :
        ensure  => file,
        source  => 'puppet:///extra_files/pre-slave.sh',
        owner  => root,
        group  => root,
        mode   => 777,
        before => Exec['pre-slave'],
        }
        exec { 'pre-slave' :
        command=> '/bin/pre-slave.sh ',
        path => '/bin:/sbin:/usr/bin:/usr/sbin',
        before => File['/etc/my.cnf'],
        }

        file { '/etc/my.cnf' :
        ensure  => file,
        source  => 'puppet:///extra_files/slave_my.cnf',
        owner  => root,
        group  => root,
        before => File['/bin/slave.sql'],
        }


        file { '/bin/slave.sql' :
        ensure  => file,
        source  => 'puppet:///extra_files/slave.sql',
        owner  => root,
        group  => root,
        mode   => 777,
        before => File['/bin/post-slave.sh'],
        }

        file { '/bin/post-slave.sh' :
        ensure  => file,
        source  => 'puppet:///extra_files/post-slave.sh',
        owner  => root,
        group  => root,
        mode   => 777,
        before => Exec['post-slave'],
        }

        exec { 'post-slave' :
        command=> '/bin/post-slave.sh ',
        path => '/bin:/sbin:/usr/bin:/usr/sbin',
        }

}

