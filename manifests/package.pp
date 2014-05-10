class packetbeat::package($version = 'present') {

  case $version {
    'present', 'latest': { $version_real = $version }
    default:             { fail('Class[packetbeat::package]: parameter version must be present or latest') }
  }

  package { 'packetbeat' :
    ensure => $version_real
  }

}
