class packetbeat::config(
  $elasticsearch_host = undef,
  $elasticsearch_port = '9200',
  $elasticsearch_protocol = 'http',
  $elasticsearch_username = undef,
  $elasticsearch_password = undef,
  $interfaces = 'any',
  $disable_procs = 'false',
  $protocols_monitored = {},
  $processes_monitored = {},
  $agent_name = $::fqdn,
  $ignore_outgoing = false
) {

  file { '/etc/packetbeat':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755'
  }

  file { '/etc/packetbeat/packetbeat.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('packetbeat/packetbeat.conf.erb')
  }

}
