class amavisd::package($ensure) inherits amavisd::params {
  package {$amavisd::params::packages:
    ensure => $ensure
  }

  group {'amavis':
    members => 'clamav'
  }
}
