class check_mk::service {

  if ! defined(Service[httpd]) {
    service { 'httpd':
      ensure => 'running',
      name   => $check_mk::http_service_name,
      enable => true,
    }
  }
  if ! defined(Service[xinetd]) {
    service { 'xinetd':
      ensure => 'running',
      name   => $check_mk::xinitd_service_name,
      enable => true,
    }
  }
  service { 'omd':
    ensure => 'running',
    name   => $check_mk::omd_service_name,
    enable => true,
  }
}
