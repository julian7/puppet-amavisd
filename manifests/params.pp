class amavisd::params {
  $packages = ['amavisd-new', 'spamassassin', 'clamav-daemon', 'libdbi-perl']
  $service = ['amavis', 'clamav-freshclam', 'clamav-daemon']
  $conf = '/etc/amavis'
}
