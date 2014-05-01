define check_mk::agent::generate_sshkey (
  # dir on the check-mk-server where the collected key pairs are stored
  $keydir,
  # dir on the check-mk-agent where the authorized_keys file is stored
  $authdir,
  # name of the authorized_keys file
  $authfile         = undef,
  # dir on the puppetmaster where keys are stored
  # FIXME: need a way to ensure this dir is setup on the puppetmaster correctly
  #$ssh_key_basepath = "${common::moduledir::module_dir_path}/check_mk/keys",
  #  for now use a dir we know works
  $ssh_key_basepath = '/etc/puppet/modules/check_mk/keys',
  $sshuser          = 'root',
  $check_mk_tag     = 'check_mk_sshkey'
){

  # generate check-mk ssh keypair, stored on puppetmaster
  $ssh_key_name = "${::fqdn}_id_rsa"
  $ssh_keys     = ssh_keygen("${ssh_key_basepath}/${ssh_key_name}")
  $public       = split($ssh_keys[1],' ')
  $public_type  = $public[0]
  $public_key   = $public[1]
  $secret_key   = $ssh_keys[0]

  # if we're not root we need to use sudo
  if $sshuser != 'root' {
    $command = 'sudo /usr/bin/check_mk_agent'
  } else {
    $command = '/usr/bin/check_mk_agent'
  }

  # setup the public half of the key in authorized_keys on the agent
  #  and restrict it to running only the agent
  if $authdir or $authfile {
    # if $authkey or $authdir are set, override authorized_keys path and file
    sshd::ssh_authorized_key { $ssh_key_name:
        type    => 'ssh-rsa',
        key     => $public_key,
        user    => 'root',
        target  => "${authdir}/${authfile}",
        options => "command=\"${command}\"";
    }
  } else {
    # otherwise use the defaults
    sshd::ssh_authorized_key { $ssh_key_name:
        type    => 'ssh-rsa',
        key     => $public_key,
        user    => 'root',
        options => "command=\"${command}\"";
    }
  }

  # resource collector for the private half of the keys, these end up on
  #  the check-mk-server host
  @@file { "${keydir}/${ssh_key_name}":
    content => $secret_key,
    owner   => root,
    group   => root,
    mode    => '0600',
    tag     => $check_mk_tag;
  }
}
