define check_mk::agent::ps (
  # procname and levels have defaults in check_mk::ps
  $procname = undef,
  $levels   = undef,
  # user is optional
  $user     = undef
) {

  include check_mk::params

  @@check_mk::ps { "${::fqdn}_${name}":
    target   => "${check_mk::params::etc_dir}/check_mk/conf.d/ps.mk",
    desc     => $name,
    host     => $::fqdn,
    procname => $procname,
    user     => $user,
    levels   => $levels,
    tag      => 'check_mk_ps';
  }
}
