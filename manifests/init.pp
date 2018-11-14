# configure check_mk server
class check_mk (
  $filestore                 = undef,
  $host_groups               = undef,
  $package                   = 'omd-0.56',
  $site                      = 'monitoring',
  $workspace                 = $check_mk::params::workspace,
  $omd_service_name          = $check_mk::params::omd_service_name,
  $http_service_name         = $check_mk::params::http_service_name,
  $xinitd_service_name       = $check_mk::params::xinetd_service_name,
  $omdadmin_htpasswd         = undef,
  $use_ssh                   = false,
  $shelluser                 = $check_mk::params::shelluser,
  $shellgroup                = $check_mk::params::shellgroup,
  $use_storedconfigs         = true,
  $inventory_only_on_changes = true
) inherits check_mk::params {

  class { 'check_mk::install':
    filestore => $filestore,
    package   => $package,
    site      => $site,
    workspace => $workspace,
  }
  class { 'check_mk::config':
    host_groups               => $host_groups,
    site                      => $site,
    use_storedconfigs         => $use_storedconfigs,
    inventory_only_on_changes => $inventory_only_on_changes,
    require                   => Class['check_mk::install'],
  }
  class { 'check_mk::service':
    require   => Class['check_mk::config'],
  }
  if $omdadmin_htpasswd {
    class { 'check_mk::htpasswd':
      password => $omdadmin_htpasswd
    }
  }

  if ( $use_ssh == true ) {
    class { 'check_mk::server::configure_ssh': }
  }

}
