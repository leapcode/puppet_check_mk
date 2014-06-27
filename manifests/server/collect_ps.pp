class check_mk::server::collect_ps (
  $config = "${::check_mk::config::etc_dir}/check_mk/conf.d/ps.mk"
) {

  concat { $config:
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Exec['check_mk-refresh'],
  }

  concat::fragment{'check_mk_ps_header':
    target  => $config,
    content => "checks += [\n",
    order   => 10,
  }

  Check_mk::Ps <<| tag == 'check_mk_ps' |>> {
    target => $config,
    notify => Exec['check_mk-refresh']
  }

  concat::fragment{'check_mk_ps_footer':
    target  => $config,
    content => "]\n",
    order   => 90,
  }

}
