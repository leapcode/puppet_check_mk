# http://mathias-kettner.de/checkmk_datasource_programs.html
datasource_programs = [
 ( "ssh -l checkmk -i /etc/check_mk/keys/<HOST>_id_rsa -p 1234 <HOST> sudo /usr/bin/check_mk_agent", ['ssh'], ALL_HOSTS ),
 ]
