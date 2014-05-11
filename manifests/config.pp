class packetbeat::config(
  $elasticsearch_host = undef,
  $elasticsearch_port = '9200',
  $interfaces = 'any',
  $disable_procs = 'false',
  $protocols_monitored = {},
  $processes_monitored = {},
  $agent_name = $::fqdn
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
