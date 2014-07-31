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
  $version = undef,
  $versionlock = false,
  $enable = true,
  $service_state = 'running',
  $elasticsearch_host = undef,
  $elasticsearch_port = '9200',
  $elasticsearch_protocol = 'http',
  $elasticsearch_username = undef,
  $elasticsearch_password = undef,
  $interfaces = 'any',
  $disable_procs = false,
  $protocols_monitored = {},
  $processes_monitored = {},
  $agent_name = $::fqdn,
  $ignore_outgoing = false
) {

  include stdlib

  if ! $version {
    fail('Class[Packetbeat]: parameter version must be provided')
  }

  case $enable {
    true, false: { $enable_real = $enable }
    default:     { fail('Class[packetbeat]: parameter enable must be a boolean') }
  }

  case $service_state {
    'running', 'stopped': { $service_state_real = $service_state }
    default:     { fail('Class[packetbeat]: parameter service_state must be running or stopped') }
  }

  if ! ($elasticsearch_protocol in ['http', 'https']) {
    fail('Class[Packetbeat]: parameter elasticsearch_protocol must be one of http or https')
  }

  case $disable_procs {
    true, false: { $disable_procs_real = $disable_procs }
    default:     { fail('Class[packetbeat]: parameter disable_procs must be a boolean') }
  }

  case $ignore_outgoing {
    true, false: { $ignore_outgoing_real = $ignore_outgoing }
    default:     { fail('Class[packetbeat]: parameter ignore_outgoing must be a boolean') }
  }

  case $::osfamily {
    'RedHat': {
      class { 'packetbeat::package':
        version     => $version,
        versionlock => $versionlock
      }

      class { 'packetbeat::config':
        elasticsearch_host     => $elasticsearch_host,
        elasticsearch_port     => $elasticsearch_port,
        elasticsearch_protocol => $elasticsearch_protocol,
        elasticsearch_username => $elasticsearch_username,
        elasticsearch_password => $elasticsearch_password,
        interfaces             => $interfaces,
        disable_procs          => $disable_procs_real,
        protocols_monitored    => $protocols_monitored,
        processes_monitored    => $processes_monitored,
        agent_name             => $agent_name,
        ignore_outgoing        => $ignore_outgoing_real
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
