define check_mk::agent::generate_sshkey (
  # dir on the check-mk-server where the collected key pairs are stored
  $keydir,
  # dir on the check-mk-agent where the authorized_keys file is stored
  $authdir,
  # name of the authorized_keys file
  $authfile         = undef,
  # dir on the puppetmaster where keys are stored
  $ssh_key_basepath = '/etc/puppet/modules/keys/files/check_mk_keys',
  # user and group to run the agent as
  $user             = 'monitoring',
  $group            = 'monitoring',
  $check_mk_tag     = 'check_mk_sshkey'
){

  # generate check-mk ssh keypair
  $ssh_key_name = "${user}_${::fqdn}_id_rsa"
  $ssh_keys     = ssh_keygen("${ssh_key_basepath}/${ssh_key_name}")
  $public       = split($ssh_keys[1],' ')
  $public_type  = $public[0]
  $public_key   = $public[1]
  $secret_key   = $ssh_keys[0]

  if $authdir or $authfile {
    # if $authkey or $authdir are set, override authorized_keys path and file
    sshd::ssh_authorized_key { $ssh_key_name:
        type    => 'ssh-rsa',
        key     => $public_key,
        user    => 'root',
        target  => "${authdir}/${authfile}",
        options => 'command="/usr/bin/check_mk_agent"';
    }
  } else {
    # otherwise use the defaults
    sshd::ssh_authorized_key { $ssh_key_name:
        type    => 'ssh-rsa',
        key     => $public_key,
        user    => 'root',
        options => 'command="/usr/bin/check_mk_agent"';
    }
  }

  # resource collector, these end up on the check-mk-server host
  @@file { "${keydir}/${ssh_key_name}":
    content => $secret_key,
    owner   => $user,
    group   => $group,
    mode    => '0600',
    tag     => $check_mk_tag;
  }

  @@file { "${keydir}/${ssh_key_name}.pub":
    content => $public_key,
    owner   => $user,
    group   => $group,
    mode    => '0666',
    tag     => $check_mk_tag;
  }
}
