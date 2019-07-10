# Class: datadog_agent::params
#
# This class contains the parameters for the Datadog module
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class datadog_agent::params {
  $datadog_site                   = 'datadoghq.com'
  $agent5_enable                  = false
  $conf_dir                       = 'c:\programdata\Datadog\conf.d'
  $conf6_dir                      = 'c:\programdata\Datadog\conf.d'
  $dd_user                        = 'ddagentuser'
  $dd_group                       = 'Administrators'
  $dd_groups                      = undef
  $package_name                   = 'datadog-agent'
  $service_name                   = 'DatadogAgent'
  $agent_version                  = 'latest'
  $dogapi_version                 = 'installed'
  $gem_provider                   = 'puppetserver_gem'
  $conf_dir_purge                 = false
  $apt_default_release            = 'stable'
  $apm_default_enabled            = false
  $process_default_enabled        = false
  $process_default_scrub_args     = true
  $process_default_custom_words   = []
  $logs_enabled                   = false
  $container_collect_all          = false
  $use_apt_backup_keyserver       = false
  $apt_backup_keyserver           = 'hkp://pool.sks-keyservers.net:80'
  $apt_keyserver                  = 'hkp://keyserver.ubuntu.com:80'
  $restart_service                = 'DDRestart'

}


