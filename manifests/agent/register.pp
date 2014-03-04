class check_mk::agent::register ($host_tags = '') {
  @@check_mk::host { $::fqdn:
    host_tags => $host_tags,
  }


}
