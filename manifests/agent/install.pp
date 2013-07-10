class check_mk::agent::install (
  $version,
  $filestore = '',
  $workspace,
  $agent_package_name,
  $agent_logwatch_package_name,
) {
  if ! defined(Package['xinetd']) {
    package { 'xinetd':
      ensure => present,
    }
  }
  if $filestore {
    if ! defined(File[$workspace]) {
      file { $workspace:
        ensure => directory,
      }
    }
    file { "${workspace}/check_mk-agent-${version}.noarch.rpm":
      ensure  => present,
      source  => "${filestore}/check_mk-agent-${version}.noarch.rpm",
      require => Package['xinetd'],
    }
    file { "${workspace}/check_mk-agent-logwatch-${version}.noarch.rpm":
      ensure  => present,
      source  => "${filestore}/check_mk-agent-logwatch-${version}.noarch.rpm",
      require => Package['xinetd'],
    }
    package { 'check_mk-agent':
      ensure   => present,
      provider => 'rpm',
      source   => "${workspace}/check_mk-agent-${version}.noarch.rpm",
      require  => File["${workspace}/check_mk-agent-${version}.noarch.rpm"],
    }
    package { 'check_mk-agent-logwatch':
      ensure   => present,
      provider => 'rpm',
      source   => "${workspace}/check_mk-agent-logwatch-${version}.noarch.rpm",
      require  => [
        File["${workspace}/check_mk-agent-logwatch-${version}.noarch.rpm"],
        Package['check_mk-agent'],
      ],
    }
  }
  else {
    package { 'check_mk-agent':
      ensure  => present,
      name    => $agent_package_name,
      require => Package['xinetd'],
    }
    package { 'check_mk-agent-logwatch':
      ensure  => present,
      name    => $agent_logwatch_package_name,
      require => Package['check_mk-agent'],
    }
  }
}
