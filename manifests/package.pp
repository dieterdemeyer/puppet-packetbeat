class packetbeat::package(
  $version = undef,
  $versionlock = false
) {

  if ! $version {
    fail('Class[Packetbeat::Package]: parameter version must be provided')
  }

  package { 'packetbeat' :
    ensure => $version
  }

  case $versionlock {
    true: {
      packagelock { 'packetbeat': }
    }
    false: {
      packagelock { 'packetbeat': ensure => absent }
    }
    default: { fail('Class[Packetbeat::Package]: parameter versionlock must be true or false')}
  }

}
