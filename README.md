Puppet & Datadog - Forked for Windows
================

This puppet module is not in the forge. Since its not in the forge, you will have to manually put that repo into a datadog_agent module, and manually `puppet module install` the 6 dependencies in metadata.json: https://github.com/mikelaning/puppet-datadog-agent/blob/master/metadata.json

Currently, it is set up with sqlserver, redis, iis, to windows_service, and wmi_check integrations to work successfully.

Here is an example manifest used that confirms successful installation and configuration:

```
node "default" {
    class { "datadog_agent":
        api_key => "<your api key>",
        agent_version => "6.12.2",
        process_enabled => true,
        logs_enabled => true,

    }
    include 'datadog_agent::integrations::wmi_check'

    class { 'datadog_agent::integrations::iis':
        tags => ['test:puppet_test','demo:mikelaning']
    }
    class { 'datadog_agent::integrations::windows_service':
        services => ['ALL']
    }

}
```

See the official puppet module for more information: https://github.com/DataDog/puppet-datadog-agent
