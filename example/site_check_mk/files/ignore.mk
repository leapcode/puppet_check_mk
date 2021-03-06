# ignore.mk - built-in checks we ignore
ignored_checktypes = [
# ignored until we can investigate
"hp_procurve_cpu", "hp_procurve_mem", "hp_procurve_sensors",
"ipmi", "ipmi_sensors",
"tcp_conn_stats",

# useful generic types, ignored until we need them
"if", "if64"
"local",
"logwatch",

# postfix_queue is only the full mailq, we have our own check_postfixqueue
#  that can check individual queue (which we filed a feature request for
#  upstream
"postfix_mailq",

# ignored because we don't want them
"3ware_disks", "3ware_info", "3ware_units",
"ad_replication",
"aironet_clients", "aironet_errors",
"akcp_sensor_humidity", "akcp_sensor_temp",
"apc_symmetra", "apc_symmetra_ext_temp", "apc_symmetra_power", "apc_symmetra_temp",
"bintec_info",
"blade_bays", "blade_blades", "blade_blowers", "blade_health", "blade_mediatray", "blade_misc", "blade_powerfan", "blade_powermod",
"bluecoat_diskcpu", "bluecoat_sensors",
"brocade_fcport",
"canon_pages",
"check_mk.only_from",
"cisco_fan", "cisco_locif", "cisco_power", "cisco_qos", "cisco_temp", "cisco_temp_perf",
"cmctc.temp",
"cpsecure_sessions",
"cups_queues",
"decru_cpu", "decru_fans", "decru_perf", "decru_power", "decru_temps",
"dell_powerconnect_cpu", "dell_powerconnect_fans", "dell_powerconnect_psu", "dell_powerconnect_temp",
"df_netapp", "df_netapp32",
"dmi_sysinfo",
"drbd", "drbd.disk", "drbd.net", "drbd.stats",
"f5_bigip_cluster", "f5_bigip_fans", "f5_bigip_pool", "f5_bigip_psu", "f5_bigip_temp", "f5_bigip_vserver",
"fc_brocade_port", "fc_brocade_port_detailed",
"fjdarye60_cadaps", "fjdarye60_cmods", "fjdarye60_cmods_flash",
"fjdarye60_cmods_mem", "fjdarye60_conencs", "fjdarye60_devencs", "fjdarye60_disks", "fjdarye60_disks.summary", "fjdarye60_expanders", "fjdarye60_inletthmls", "fjdarye60_psus", "fjdarye60_rluns", "fjdarye60_sum", "fjdarye60_syscaps", "fjdarye60_thmls",
"fsc_fans", "fsc_ipmi_mem_status", "fsc_subsystems", "fsc_temp",
"h3c_lanswitch_cpu", "h3c_lanswitch_sensors",
"heartbeat_crm", "heartbeat_crm.resources", "heartbeat_nodes", "heartbeat_rscstatus",
"hp_blade", "hp_blade_blades", "hp_blade_fan", "hp_blade_manager", "hp_blade_psu",
"hp_proliant_cpu", "hp_proliant_da_phydrv", "hp_proliant_fans", "hp_proliant_mem", "hp_proliant_psu", "hp_proliant_temp",
"hpux_cpu", "hpux_if", "hpux_lvm", "hpux_multipath", "hpux_serviceguard",
"hr_cpu", "hr_fs", "hr_mem",
"ibm_imm_health", "ibm_rsa_health",
"if", "if64",
"ifoperstatus",
"ironport_misc",
"j4p_performance.app_sess", "j4p_performance.app_state", "j4p_performance.mem", "j4p_performance.serv_req", "j4p_performance.threads", "j4p_performance.uptime",
"kernel.util",
"lparstat_aix",
"lsi.array", "lsi.disk",
"mbg_lantime_refclock", "mbg_lantime_state",
"mcdata_fcport",
"megaraid_ldisks", "megaraid_pdisks",
"mem.vmalloc",
"mem.win",
"multipath",
"netapp_cluster", "netapp_vfiler", "netapp_volumes",
"netctr.combined",
"netif.link", "netif.params",
"nfsmounts",
"ntp", "ntp.time",
"nvidia.errors", "nvidia.temp",
"omd_status",
"oracle_asm_dg", "oracle_asm_disk", "oracle_inst", "oracle_logswitches", "oracle_sessions", "oracle_tablespaces", "oracle_tbs",
"printer_alerts", "printer_pages", "printer_supply",
"ps.perf",
"services",
"smbios_sel",
"snia_sml",
"snmp_info", "snmp_uptime",
"statgrab_cpu", "statgrab_disk", "statgrab_load", "statgrab_mem", "statgrab_net.ctr", "statgrab_net.link", "statgrab_net.params",
"steelhead_connections", "steelhead_status",
"strem1_sensors",
"superstack3_sensors",
"sylo",
"systemtime",
"tsm_stgpool",
"ucd_cpu_load", "ucd_cpu_util",
"ups_capacity", "ups_power",
"vbox_guest",
"vms_df", "vms_md", "vms_netif", "vms_sys.mem", "vms_sys.util",
"vmstat_aix",
"vmware_state",
"win_dhcp_pools", "win_dhcp_pools.stats",
"windows_updates",
"winperf.cpuusage", "winperf.diskstat", "winperf_msx_queues", "winperf_phydisk", "winperf_processor.util",
"wmic_process",
"wut_webtherm",
"zpool_status"
]
