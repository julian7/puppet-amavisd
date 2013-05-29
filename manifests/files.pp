class amavisd::files(
  $dbistr = undef,
  $dbname = undef,
  $dbpass = undef,
  $domains_table = 'domains',
  $domains_domain = 'domain'
) inherits amavisd::params {
  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Class['amavisd::service']
  }

  $directory = 'directory'
  $sqlensure = $dbistr ? {
    undef   => 'absent',
    default => 'present'
  }

  file {
    $conf:
      ensure  => $directory,
      mode    => '0755',
      recurse => true,
      purge   => true
      ;
    "${conf}/en_US":
      ensure  => $directory,
      mode    => '0755',
      recurse => true,
      source  => 'puppet:///modules/amavisd/en_US'
      ;
    "${conf}/conf.d":
      ensure  => $directory,
      mode    => '0755',
      recurse => true,
      source  => 'puppet:///modules/amavisd/conf.d'
      ;
    "${conf}/conf.d/50-sql":
      ensure  => $sqlensure,
      mode    => '0600',
      content => template('amavisd/50-sql.erb')
      ;
  }
}
