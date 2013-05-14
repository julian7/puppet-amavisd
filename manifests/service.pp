class amavisd::service($ensure) {
  service { 'amavis':
    ensure     => $ensure,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['Amavis::Package'] # + Class['Amavis::Config']
  }
}
