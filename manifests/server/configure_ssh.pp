class check_mk::server::configure_ssh (
  $check_mk_tag     = 'check_mk_sshkey'
  $etc_dir          = $check_mk::params::etc_dir,
  $shelluser        = $check_mk::params::shelluser,
  $shellgroup       = $check_mk::params::shellgroup,
) inherit check_mk::params {
  # collect exported files from client::generate_sshkey
  File <<| tag == $check_mk_tag |>>

  # configure ssh access to agents which have 'ssh' tags
  file { "${etc_dir}/check_mk/conf.d/use_ssh.mk":
    source => [ 'puppet:///modules/site_check_mk/use_ssh.mk',
                'puppet:///modules/check_mk/use_ssh.mk' ],
    owner  => $shelluser,
    group  => $shellgroup,
    mode   => '0644',
    notify => Exec['check_mk-refresh']
  }
}
