class check_mk::agent::register (
  $host_tags = '',
  $hostname  = $::fqdn,
  $etc_dir   = $check_mk::params::etc_dir
) inherits check_mk::params { 
  @@check_mk::host { $hostname:
    host_tags => $host_tags,
    target    => "${etc_dir}/check_mk/main.mk",
  }
}
