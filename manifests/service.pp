class packetbeat::service(
  $ensure = undef,
  $enable = undef
) {

  case $ensure {
    'running', 'stopped': { $ensure_real = $ensure }
    default:              { fail('Class[packetbeat::service]: parameter ensure must be running or stopped') }
  }

  case $enable {
    true, false: { $enable_real = $enable }
    default:     { fail('Class[packetbeat::service]: parameter enable must be a boolean') }
  }

  service { 'packetbeat':
    ensure => $ensure_real,
    enable => $enable_real
  }

}
