
class datadog_agent::integrations::wmi_check inherits datadog_agent::params {
  include datadog_agent

  $dst_dir = "${datadog_agent::conf6_dir}/wmi_check.d"

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
    content => template('datadog_agent/agent-conf.d/wmi_check.yaml.erb'),
    require => Package[$datadog_agent::params::package_name],
    notify  => Exec[$datadog_agent::params::restart_service]
  }
}
