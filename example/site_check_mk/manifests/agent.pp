class site_check_mk::agent {

  $tags = hiera('check_mk-tags')

  class { 'check_mk::agent':
    # FIXME: the check_mk module should be enhanced to detect debian so we
    #  don't need to set these
    agent_package_name          => 'check-mk-agent',
    agent_logwatch_package_name => 'check-mk-agent-logwatch',
    # we use ssh rather than xinetd and have puppet generate and collect keys
    method                      => 'ssh',
    generate_sshkey             => true,
    sshuser                     => 'checkmk',
    # where keys get stored on the check-mk-server (default is an OMD dir)
    keydir                      => '/etc/check_mk/keys',
    # we(riseup) override where authorized keys are stored, since we use a
    #  central directory of user named files rather than
    #  ~user/.ssh/authorized_keys
    authdir                     => '/etc/ssh/authorized_keys',
    authfile                    => 'checkmk',
    host_tags                   => $tags
  }

  # we ssh as the checkmk user and allow checkmk to run check_mk_agent
  #   with sudo (rather than ssh as root)
  if !defined(User[checkmk]) {
    user { 'checkmk':
      ensure   => 'present',
      home     => '/usr/lib/check_mk_agent',
      gid      => 'users',
      password => '*',
      comment  => 'check_mk agent';
    }
  }

  include site_sudo

  sudo::access { 'checkmk':
    user   => 'checkmk',
    access => 'ALL= NOPASSWD: /usr/bin/check_mk_agent'
  }

  # include checks we want on all agents here
  # NOTE: we're currently doing this here, it could also be done within
  # the actual classes related to the check (as we've done before with munin)
  include site_check_mk::agent::apt

  # not enabled yet
  #include site_check_mk::agent::logwatch
}
