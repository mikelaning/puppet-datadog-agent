class datadog_agent::windows (
  $baseurl = "https://s3.amazonaws.com/ddagent-windows-stable/ddagent-cli-${datadog_agent::agent_version}.msi") {
  validate_string($baseurl)

  file { 'c:\datadoginstaller':
    ensure => directory,
    owner  => 'Administrator',
    group  => 'Administrators',
    notify => Exec['getdatadog-installer']
  }

  exec { 'getdatadog-installer':
    command  => "invoke-webrequest $baseurl -outfile c:/datadoginstaller/ddagent-cli-${datadog_agent::agent_version}.msi",
    onlyif   => "if ((test-path c:/datadoginstaller/ddagent-cli-${datadog_agent::agent_version}.msi) -eq \$true) {exit 1}",
    provider => powershell,
    notify   => Package['datadog-agent'],
  }

  package { 'datadog-agent':
    ensure          => "${datadog_agent::agent_version}",
    source          => "C:/datadoginstaller/ddagent-cli-${datadog_agent::agent_version}.msi",
    install_options => [{
        'APIKEY' => "${datadog_agent::api_key}",
      }
      ],
  }
  exec { 'DDRestart':
    command  => "& 'C:\Program Files\Datadog\Datadog Agent\embedded\agent.exe' restart-service",
    provider => powershell,
  }
  
  service { 'DatadogAgent':
    ensure  => $::datadog_agent::service_ensure,
    enable  => $::datadog_agent::service_enable,
    require => Package['datadog-agent'],
  }
}
