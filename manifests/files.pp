class amavisd::files(
  $dbistr = undef,
  $dbname = undef,
  $dbpass = undef,
  $domains_table = 'domains',
  $domains_domain = 'domain',
  $virus_checking = false,
  $spam_checking = false
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
  $avensure = $virus_checking ? {
    true    => 'present',
    default => 'absent'
  }
  $avspamensure = $virus_checking ? {
    true  => 'present',
    false => $spam_checking ? {
      true  => 'present',
      false => 'absent'
    }
  }

  $conf = $amavisd::params::conf
  $confd = "${amavisd::params::conf}/conf.d"

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
    $confd:
      ensure  => $directory,
      mode    => '0755',
      recurse => true,
      source  => 'puppet:///modules/amavisd/conf.d'
      ;
    "${confd}/15-av_scanners":
      ensure  => $avensure,
      content => template('amavisd/15-av_scanners.erb')
      ;
    "${confd}/15-content_filter_mode":
      ensure  => $avspamensure,
      content => template('amavisd/15-content_filter_mode.erb')
      ;
    "${confd}/50-sql":
      ensure  => $sqlensure,
      mode    => '0600',
      content => template('amavisd/50-sql.erb')
      ;
  }
}
