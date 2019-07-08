# Class: datadog_agent::integrations::sqlserver
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
# include 'datadog_agent::integrations::sqlserver'
#
# OR
#
# class { 'datadog_agent::integrations::sqlserver':
#   url      => 'LOCALHOST,1433',
#   username => 'status',
#   password => 'hunter1',
#}
#
class datadog_agent::integrations::sqlserver (

  $sqlhostandport = 'LOCALHOST,1433',
  $username       = undef,
  $password       = undef,
  $tags           = []
) inherits datadog_agent::params {
  
  include datadog_agent
  
  validate_string($sqlhostandport)
  validate_array($tags)





) inherits datadog_agent::params {
  include datadog_agent
  
  $dst_dir = "${datadog_agent::conf6_dir}/sqlserver.d"

  file { $dst_dir:
      ensure  => directory,
      owner   => $datadog_agent::params::dd_user,
      group   => $datadog_agent::params::dd_group,
      mode    => '0755',
      require => Package[$datadog_agent::params::package_name],
      notify  => Service[$datadog_agent::params::service_name]
  }
    $dst = "${dst_dir}/conf.yaml"
  

  file { $dst:
    ensure  => file,
    owner   => $datadog_agent::params::dd_user,
    group   => $datadog_agent::params::dd_group,
    mode    => '0600',
    content => template('datadog_agent/agent-conf.d/sqlserver.yaml.erb'),
    require => Package[$datadog_agent::params::package_name],
    notify  => Service[$datadog_agent::params::service_name]
  }
}
