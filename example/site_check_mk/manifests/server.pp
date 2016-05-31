class site_check_mk::server {

  # we don't use the main check_mk class, but call things a la carte. The
  #  main class does:
  #  check_mk::install -> we don't want OMD, we install the debian packages
  #  check_mk::config  -> we call below with special settings
  #  check_mk::service -> service checks for http/xinetd/omd, we don't want
  #  check_mk::server::configure_ssh -> we call below
  # FIXME: if the check_mk module was more generic and less OMD focused,
  #  it would just know what to do for a debian install and we could use
  #  the main check_mk class with the right parameters, rather than a la carte

  # install the server package, this also pulls in check-mk-config-nagios3
  # FIXME: the check_mk module should be enhanced to better support distro
  #  installs and then we'd just set a $distro parameter and it would
  #  detect debian and install the right packages. But until it does...
  package { 'check-mk-server':
    ensure => installed,
  }

  # the server needs check_icmp (among others)
  if !defined(Package['nagios-plugins-basic']) {
    package { 'nagios-plugins-basic': ensure => installed }
  }

  # flush config for certain config changes
  # FIXME: after testing, maybe this can go in the generic module
  exec { 'check_mk-flush':
    command     => "/bin/su -l -c '${bin_dir}/check_mk --flush' ${site}",
    refreshonly => true,
    notify      => Exec['check_mk-reload'],
  }

  file {
    '/etc/check_mk/keys':
      ensure => directory;

    # don't generate host defines
    '/etc/check_mk/conf.d/nohost.mk':
      source => 'puppet:///modules/site_check_mk/nohost.mk',
      owner  => root,
      group  => root,
      mode   => '0644',
      notify => Exec['check_mk-refresh'];

    # setup parent relationships
    '/etc/check_mk/conf.d/parents.mk':
      source => 'puppet:///modules/site_check_mk/parents.mk',
      owner  => root,
      group  => root,
      mode   => '0644',
      notify => Exec['check_mk-refresh'];

    # checks we ignore (requires a flush to get them to go away)
    '/etc/check_mk/conf.d/ignore.mk':
      source => 'puppet:///modules/site_check_mk/ignore.mk',
      owner  => root,
      group  => root,
      mode   => '0644',
      notify => Exec['check_mk-flush'];

    # checks we adjust (requires reload so checks are recompiled)
    '/etc/check_mk/conf.d/adjust.mk':
      source => 'puppet:///modules/site_check_mk/adjust.mk',
      owner  => root,
      group  => root,
      mode   => '0644',
      notify => Exec['check_mk-reload'];

    # check_icmp must be suid root or called by sudo
    # see https://leap.se/code/issues/5171
    '/usr/lib/nagios/plugins/check_icmp':
      mode    => '4755',
      require => Package['nagios-plugins-basic'];
  }

  # override paths to use the system check_mk rather than OMD
  class { 'check_mk::config':
    # default site is  'monitoring', we set to blank
    site          => '',
    # etc_dir is an OMD dir by default, we use /etc resulting in /etc/check_mk
    etc_dir       => '/etc',
    # nagios_subdir is nagios by default, debian uses nagios3
    nagios_subdir => 'nagios3',
    # bin_dir is an OMD dir by default, we use the system path for debian
    bin_dir       => '/usr/bin',
    # all our hosts are in the same group
    host_groups   => undef,
    # use_storedconfigs default is true, which we want
    # make sure the check-mk-server is installed or initial config will fail
    # FIXME: like the above, this should move into the check_mk module
    require       => Package['check-mk-server']
  }

  class { 'check_mk::server::configure_ssh': }
}
