# Class: packetbeat
#
# This module manages packetbeat
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class packetbeat(
  $version = 'present',
  $enable = true,
  $service_state = 'running',
  $elasticsearch_host = undef,
  $elasticsearch_port = '9200',
  $interfaces = 'any',
  $disable_procs = 'false',
  $protocols_monitored = {},
  $processes_monitored = {},
  $agent_name = $::fqdn
) {

  case $version {
    'present', 'latest': { $version_real = $version }
    default:             { fail('Class[packetbeat]: parameter version must be present or latest') }
  }

  case $enable {
    true, false: { $enable_real = $enable }
    default:     { fail('Class[packetbeat]: parameter enable must be a boolean') }
  }

  case $service_state {
    'running', 'stopped': { $service_state_real = $service_state }
    default:     { fail('Class[packetbeat]: parameter service_state must be running or stopped') }
  }

  case $::osfamily {
    'RedHat': {
      class { 'packetbeat::package':
        version => $version_real
      }
      class { 'packetbeat::config':
        elasticsearch_host  => $elasticsearch_host,
        elasticsearch_port  => $elasticsearch_port,
        interfaces          => $interfaces,
        disable_procs       => $disable_procs,
        protocols_monitored => $protocols_monitored,
        processes_monitored => $processes_monitored,
        agent_name          => $agent_name
      }
      class { 'packetbeat::service':
        ensure => $service_state_real,
        enable => $enable_real
      }

      Class['packetbeat::package'] -> Class['packetbeat::config']
      Class['packetbeat::config'] ~> Class['packetbeat::service']
      Class['packetbeat::service'] -> Class['packetbeat']
    }
    default: {
      fail("Class['packetbeat']: osfamily ${::osfamily} is not supported")
    }
  }

}
