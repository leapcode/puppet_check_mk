class check_mk::params {

  $site                      = 'monitoring'
  $etc_dir                   = "/omd/sites/${site}/etc"
  $bin_dir                   = "/omd/sites/${site}/bin"
  $omd_service_name          = 'omd'
  $http_service_name         = 'httpd'
  $xinitd_service_name       = 'xinetd'
  $shelluser                 = 'monitoring'
  $shellgroup                = 'monitoring'
  $workspace                 = '/root/check_mk'

}
