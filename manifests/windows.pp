class datadog_agent::windows (
  $baseurl = "https://s3.amazonaws.com/ddagent-windows-stable/ddagent-cli-${datadog_agent::agentversion}.msi") {
  validate_string($baseurl)

  file { 'c:\datadoginstaller':
    ensure => directory,
    owner  => 'Administrator',
    group  => 'Administrators',
    notify => Exec['getdatadog-installer']
  }

  exec { 'getdatadog-installer':
    command  => "invoke-webrequest $baseurl -outfile c:/datadoginstaller/ddagent-cli-${datadog_agent::agentversion}.msi",
    onlyif   => "if ((test-path c:/datadoginstaller/ddagent-cli-${datadog_agent::agentversion}.msi) -eq \$true) {exit 1}",
    provider => powershell,
    notify   => Package['datadog-agent'],
  }

  package { 'datadog-agent':
    ensure          => "${datadog_agent::agentversion}.0",
    source          => "C:/datadoginstaller/ddagent-cli-${datadog_agent::agentversion}.msi",
    install_options => [{
        'APIKEY' => "${datadog_agent::api_key}",
      }
      ],
  }

  service { 'DatadogAgent':
    ensure  => $::datadog_agent::service_ensure,
    enable  => $::datadog_agent::service_enable,
    require => Package['datadog-agent'],
  }
}
