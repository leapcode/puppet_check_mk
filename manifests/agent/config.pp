class check_mk::agent::config (
  $ip_whitelist = '',
  $port,
  $server_dir,
  $homedir,
  $use_cache,
  $user,
  $use_ssh = false
) {
  if $use_cache {
    $server = "${server_dir}/check_mk_caching_agent"
  }
  else {
    $server = "${server_dir}/check_mk_agent"
  }

  if ( $use_ssh == true ){
    check_mk::agent::generate_sshkey { 'check_mk_key':
      homedir => $homedir
    }
  } else {

    if $ip_whitelist {
      $only_from = join($ip_whitelist, ' ')
    }
    else {
      $only_from = undef
    }
    file { '/etc/xinetd.d/check_mk':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      content => template('check_mk/agent/check_mk.erb'),
      require => Package['check_mk-agent','check_mk-agent-logwatch'],
      notify  => Class['check_mk::agent::service'],
    }
  }
}
