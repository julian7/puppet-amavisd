class amavisd::package($ensure) {
  package {'amavisd-new':
    ensure => $ensure
  }
}
