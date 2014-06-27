define check_mk::ps (
  $target,
  $host,
  $desc,
  $procname = "/usr/sbin/${desc}",
  $levels = '1, 1, 1, 1',
  $user = undef
) {

  # lines look like
  # ( "foo.example.com", "ps", "NAME", ( "/usr/sbin/foo", 1, 1, 1, 1 ) )
  # or with a user
  # ( "foo.example.com", "ps", "NAME", ( "/usr/sbin/foo", "user", 1, 1, 1, 1 ) )
  if $user {
    $check = "  ( \"${host}\", \"ps\", \"${desc}\", ( \"${procname}\", ${user}, ${levels} ) ),\n"
  } else {
    $check = "  ( \"${host}\", \"ps\", \"${desc}\", ( \"${procname}\", ${levels} ) ),\n"
  }

  # FIXME: we could be smarter about this and consolidate host checks that have
  #  identical settings and that would make the config file make more sense
  #  for humans. but for now we'll just do separate lines.
  concat::fragment { "check_mk_ps-${host}_${desc}":
    target  => $target,
    content => $check,
    order   => 20
  }
}

