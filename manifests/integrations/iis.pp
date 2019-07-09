# Class: datadog_agent::integrations::iis
#
# This class will install the necessary configuration for the iis integration
#
# Parameters:
#   $url:
#       The URL for iis status URL handled by mod-status.
#       Defaults to http://localhost/server-status?auto
#   $username:
#   $password:
#       If your service uses basic authentication, you can optionally
#       specify a username and password that will be used in the check.
#       Optional.
#   $tags
#       Optional array of tags
#
# Sample Usage:
#
# include 'datadog_agent_windows::integrations::iis'
#

class datadog_agent::integrations::iis ($tags = []) inherits datadog_agent::params {
  validate_array($tags)

  $dst_dir = "${datadog_agent::conf6_dir}/iis.d"

  file { $dst_dir:
      ensure  => directory,
      owner   => $datadog_agent::params::dd_user,
      group   => $datadog_agent::params::dd_group,
      #mode    => '0755',
      require => Package[$datadog_agent::params::package_name],
      notify  => Exec[$datadog_agent::params::restart_service]
  }
  $dst = "${dst_dir}/conf.yaml"
  
  file { $dst:
    ensure  => file,
    owner   => $datadog_agent::params::dd_user,
    group   => $datadog_agent::params::dd_group,
    #mode    => '0600',
    content => template('datadog_agent/agent-conf.d/iis.yaml.erb'),
    require => Package[$datadog_agent::params::package_name],
    notify  => Exec[$datadog_agent::params::restart_service]
  }
}
