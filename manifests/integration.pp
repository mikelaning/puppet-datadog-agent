define datadog_agent::integration (
  $instances,
  $init_config = undef,
  $logs        = undef,
  $integration = $title,
){

  include datadog_agent

  validate_legacy(Array, 'validate_array', $instances)
  validate_legacy(Optional[Hash], 'validate_hash', $init_config)
  validate_legacy(Optional[Array], 'validate_array', $logs)
  validate_legacy(String, 'validate_string', $integration)

  $dst = "${datadog_agent::conf6_dir}/${integration}.d/conf.yaml"
  file { "${datadog_agent::conf6_dir}/${integration}.d":
    ensure => directory,
    owner  => $datadog_agent::dd_user,
    group  => $datadog_agent::dd_group,
    #mode   => '0755',
    before => File[$dst]
  }
  

  file { $dst:
    ensure  => file,
    owner   => $datadog_agent::dd_user,
    group   => $datadog_agent::dd_group,
    #mode    => '0644',
    content => to_instances_yaml($init_config, $instances, $logs),
    notify  => Exec[$datadog_agent::params::restart_service]
  }

}
