class amavisd::service($ensure) inherits amavisd::params {
  service { $amavisd::params::service:
    ensure     => $ensure,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => [Class['Amavisd::Package'], Class['Amavisd::Files']]
  }
}
