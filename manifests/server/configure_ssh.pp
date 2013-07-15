class check_mk::server::configure_ssh (
  $check_mk_tag     = 'check_mk_sshkey'
) {
  # collect exported files from client::generate_sshkey
  File <<| tag == $check_mk_tag |>>

  # configure ssh access to agents which have 'ssh' tags
  $etcdir = $check_mk::etcdir
  file { "${check_mk::etc_dir}/conf.d/use_ssh.mk":
    source => [ 'puppet:///modules/site_check_mk/use_ssh.mk',
                'puppet:///modules/check_mk/use_ssh.mk' ],
  }
}
