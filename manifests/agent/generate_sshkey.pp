define check_mk::agent::generate_sshkey(
  $ssh_key_basepath = '/etc/puppet/modules/keys/files/check_mk_keys',
  $user             = 'monitoring',
  $group            = 'monitoring',
  $homedir          = '/omd/sites/monitoring',
  $check_mk_tag     = 'check_mk_sshkey'
){

  # generate backupninja ssh keypair
  $ssh_key_name = "monitoring_${::fqdn}_id_rsa"
  $ssh_keys     = ssh_keygen("${ssh_key_basepath}/${ssh_key_name}")
  $public       = split($ssh_keys[1],' ')
  $public_type  = $public[0]
  $public_key   = $public[1]
  $secret_key   = $ssh_keys[0]

  sshd::ssh_authorized_key { $ssh_key_name:
      type    => 'ssh-rsa',
      key     => $public_key,
      user    => 'root',
      options => 'command="/usr/bin/check_mk_agent"';
  }

  @@file { "${homedir}/.ssh/${ssh_key_name}":
    content => $secret_key,
    owner   => $user,
    group   => $group,
    mode    => '0600',
    tag     => $check_mk_tag;
  }


  @@file { "${homedir}/.ssh/${ssh_key_name}.pub":
    content => $public_key,
    owner   => $user,
    group   => $group,
    mode    => '0666',
    tag     => $check_mk_tag;
  }


}
