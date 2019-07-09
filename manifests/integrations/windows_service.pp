# Class: datadog_agent::integrations::windows_service
#
# This class will install the necessary configuration for the sqlserver integration
#
# Parameters:
#   $url:
#       The URL for sqlserver status URL handled by mod-status.
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
# include 'datadog_agent::integrations::windows_service'
#
# OR
#
# class { 'datadog_agent::integrations::windows_service':
#   url      => 'LOCALHOST,1433',
#   username => 'status',
#   password => 'hunter1',
#}
#

class datadog_agent::integrations::windows_service ($services = []) inherits datadog_agent::params {
 
  include datadog_agent
  
  validate_array($services)
  
  $dst_dir = "${datadog_agent::conf6_dir}/windows_service.d"

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
      content => template('datadog_agent/agent-conf.d/windows_service.yaml.erb'),
      require => Package[$datadog_agent::params::package_name],
      notify  => Exec[$datadog_agent::params::restart_service]
  } 
}
