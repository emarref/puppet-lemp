apt::source { 'dotdeb':
    location   => 'http://packages.dotdeb.org',
    release    => 'squeeze',
    repos      => 'all',
    key        => '89DF5277',
    key_server => 'keys.gnupg.net'
}

apt::source { 'percona':
    location          => 'http://repo.percona.com/apt',
    release           => 'precise',
    repos             => 'main',
    key               => '1C4CBDCDCD2EFD2A',
    key_server        => 'keys.gnupg.net',
    include_src       => true,
}

file { '/etc/php5/cli':
    ensure => directory
}

file { '/etc/php5/fpm':
    ensure => directory
}

package { ['puppet', 'htop', 'vim']:
    ensure  => latest,
    require => Exec['apt_update']
}

class {
    'apt':;
    'nginx':;
    'mysql::server':;
    'php::fpm::daemon':
        require => File['/etc/php5/fpm'];
    'php::cli':
        require => File['/etc/php5/cli'];
}

php::ini {
    '/etc/php5/cli/php.ini':
        display_errors => 'On',
        memory_limit   => '256M',
        date_timezone  => 'UTC';

    '/etc/php5/fpm/php.ini':
        display_errors => 'On',
        memory_limit   => '256M',
        date_timezone  => 'UTC';
}

# Ensure the php and percona sources are added and apt updated before attempting to install percona
Apt::Source['percona'] -> Anchor['mysql::server::start']
