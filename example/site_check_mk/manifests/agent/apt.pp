class site_check_mk::agent::apt {
  include check_mk::agent::mrpe


  # we deliver a wrapper to check_apt that makes it more useful
  augeas {
    "Apt":
      incl    => '/etc/check_mk/mrpe.cfg',
      lens    => 'Spacevars.lns',
      changes => 'set APT "/usr/local/lib/nagios/plugins/check_apt -t 30"',
      require => [ File['/usr/local/lib/nagios/plugins' ], Package['check-mk-agent'] ];
  }

  # installing a local plugin, so include this to get the dirs
  include site_nagios::localplugin

  file {
    '/usr/local/lib/nagios/plugins/check_apt':
      source  => 'puppet:///modules/site_check_mk/agent/apt/check_apt',
      owner   => root,
      group   => root,
      mode    => '0750',
      require => [ File['/usr/local/lib/nagios/plugins' ], Package['nagios-plugins-basic'] ];
  }
}
