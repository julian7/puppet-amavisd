class amavisd::params {
  $packages = ['amavisd-new', 'spamassassin', 'clamav-daemon']
  $service = ['amavis', 'clamav-freshclam', 'clamav-daemon']
  $conf = '/etc/amavis'
}
