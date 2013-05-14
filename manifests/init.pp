class amavisd($ensure = 'present') {
  $running = $ensure ? {'absent' => 'absent', default => 'running'}

  class {
    amavisd::package:
      ensure => $ensure
      ;
    amavisd::service:
      ensure => $running
      ;
  }
}
