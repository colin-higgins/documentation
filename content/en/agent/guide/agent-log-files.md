---
title: Agent Log Files
kind: guide
disable_toc: true
aliases:
  - /agent/faq/agent-log-files
further_reading:
- link: "agent/troubleshooting/"
  tag: "Documentation"
  text: "Agent Troubleshooting"
- link: "agent/guide/agent-configuration-files/"
  tag: "FAQ"
  text: "Agent configuration files"
- link: "agent/guide/agent-commands/"
  tag: "FAQ"
  text: "Agent commands"
---

The Datadog Agent does a logs rollover every 10MB. When a rollover occurs, one backup is kept (e.g. `agent.log.1`). If a previous backup exists, it is overwritten during the rollover.

## Agent log directory

{{< tabs >}}
{{% tab "Agent v6" %}}

| Platform                             | Command                       |
|--------------------------------------|-------------------------------|
| Linux                                | `/var/log/datadog/`           |
| macOS                                | `/var/log/datadog/`           |
| Windows Server 2008, Vista and newer | `C:\ProgramData\Datadog\logs` |
| Windows Server 2003, XP or older     | *unsupported Platform*        |


{{% /tab %}}
{{% tab "Agent v5" %}}

| Platform                             | Command                                                              |
|--------------------------------------|----------------------------------------------------------------------|
| Linux                                | `/var/log/datadog/`                                                  |
| CentOS                               | `/var/log/datadog/`                                                  |
| Debian                               | `/var/log/datadog/`                                                  |
| Fedora                               | `/var/log/datadog/`                                                  |
| macOS                                | `/var/log/datadog/`                                                  |
| RedHat                               | `/var/log/datadog/`                                                  |
| Source                               | `~/.datadog-agent/supervisord/logs/`                                 |
| SmartOS                              | `/opt/local/datadog/logs/supervisord/`                               |
| Ubuntu                               | `/var/log/datadog/`                                                  |
| Windows Server 2008, Vista and newer | `C:\ProgramData\Datadog\logs\`                                       |
| Windows Server 2003, XP or older     | `C:\Documents and Settings\All Users\Application Data\Datadog\logs\` |

{{% /tab %}}
{{< /tabs >}}

## Agent log files

{{< tabs >}}
{{% tab "Agent v6" %}}

* `agent.log`
* `process-agent.log`
* `trace-agent.log`

{{% /tab %}}
{{% tab "Agent v5" %}}

* `collector.log`
* `dogstatsd.log`
* `forwarder.log`
* `supervisord.log`

{{% /tab %}}
{{< /tabs >}}

## Further Reading

{{< partial name="whats-next/whats-next.html" >}}
