---
title: Tracer des applications Docker
kind: Documentation
aliases:
  - /fr/tracing/docker/
  - /fr/tracing/setup/docker/
  - /fr/agent/apm/docker
further_reading:
  - link: 'https://github.com/DataDog/datadog-agent/tree/master/pkg/trace'
    tag: Github
    text: Code source
  - link: 'https://docs.datadoghq.com/integrations/amazon_ecs/#collecte-de-traces'
    tag: Documentation
    text: Tracer vos applications ECS
  - link: tracing/visualization/
    tag: Documentation
    text: 'Explorer vos services, ressources et traces'
---
Activez l'Agent de trace dans le conteneur `datadog/agent` en transmettant `DD_APM_ENABLED=true` en tant que variable d'environnement.

## Tracing depuis le host

Ajoutez l'option `-p 127.0.0.1:8126:8126/tcp` à la commande `docker run` pour bénéficier du tracing sur le port `8126/tcp` depuis *votre host uniquement*.

Pour profiter du tracing depuis *tous les hosts*, utilisez plutôt la commande `-p 8126:8126/tcp`.

Par exemple, la commande suivante permet à l'Agent de recevoir des traces depuis votre host uniquement :

```
docker run -d -v /var/run/docker.sock:/var/run/docker.sock:ro \
              -v /proc/:/host/proc/:ro \
              -v /sys/fs/cgroup/:/host/sys/fs/cgroup:ro \
              -p 127.0.0.1:8126:8126/tcp \
              -e DD_API_KEY=<VOTRE_CLÉ_API> \
              -e DD_APM_ENABLED=true \
              datadog/agent:latest
```
## Variables d'environnement de l'Agent APM Docker

Voici la liste de l'ensemble des variables d'environnements pour le tracing au sein de l'Agent Docker :

| Variable d'environnement       | Description                                                                                                               |
| ------                     | ------                                                                                                                    |
| `DD_API_KEY`               | [Clé d'API Datadog][1]                                                                                                      |
| `DD_PROXY_HTTPS`           | Configure l'URL utilisée par le proxy.                                                                                      |
| `DD_HOSTNAME`              | Définit manuellement le hostname à utiliser pour les métriques si la détection automatique échoue, ou lors de l'exécution de l'Agent de cluster Datadog.                                    |
| `DD_DOGSTATSD_PORT`        | Définit le port DogStatsD.                                                                                                   |
| `DD_BIND_HOST`             | Définit le hostname StatsD et le hostname du récepteur.                                                                                       |
| `DD_LOG_LEVEL`             | Définit le niveau de journalisation (`trace`, `debug`, `info`, `warn`, `error`, `critical` ou `off`).                                           |
| `DD_APM_ENABLED`           | Lorsque ce paramètre est défini sur `true`, l'Agent Datadog accepte les métriques de trace.                                                              |
| `DD_APM_CONNECTION_LIMIT`  | Définit la limite maximale de connexion pour un intervalle de 30 secondes.                                                            |
| `DD_APM_DD_URL`            | Endpoint de l'API Datadog vers lequel les traces sont envoyées. Pour le site européen de Datadog, définissez `DD_APM_DD_URL` sur `https://trace.agent.datadoghq.eu`. |
| `DD_APM_RECEIVER_PORT`     | Port sur lequel le récepteur de traces de l'Agent Datadog effectue son écoute. Valeur par défaut : `8126`.                                          |
| `DD_APM_NON_LOCAL_TRAFFIC` | Autorise le trafic non local pour le [tracing depuis d'autres conteneurs](#tracing-depuis-d-autres-conteneurs).                             |
| `DD_APM_IGNORE_RESOURCES`  | Configurez les ressources que l'Agent doit ignorer. Utilisez des expressions régulières séparées par des virgules, par exemple : <code>"GET /ignorer-ceci,(GET&#124;POST) /et-cela"</code>. |
| `DD_APM_ANALYZED_SPANS`    | Configurez les spans à analyser pour les transactions. Utilisez des instances de <code>\<NOM_SERVICE>&#124;\<NOM_OPÉRATION>=1</code> séparées par des virgules, par exemple : <code>mon-app-express&#124;express.request=1,mon-app-dotnet&#124;aspnet_core_mvc.request=1</code>. Vous pouvez également [l'activer automatiquement][2] à l'aide du paramètre de configuration dans le client de tracing.|
| `DD_APM_ENV`               | Définit l'[environnement][3] par défaut de vos traces.                                                                        |
| `DD_APM_MAX_EPS`           | Définit le nombre maximum d'événements APM par seconde.                                                                                   |
| `DD_APM_MAX_TPS`           | Définit le nombre maximum de traces par seconde.                                                                                       |

## Tracing depuis d'autres conteneurs

Comme pour DogStatsD, les traces peuvent être envoyées à l'Agent depuis d'autres conteneurs via les [réseaux Docker](#reseau-docker) ou l'[IP de host Docker](#ip-de-host).

### Réseau Docker

Commencez par créer un pont défini par l'utilisateur :

```bash
docker network create <NOM_RÉSEAU>
```

Démarrez ensuite l'Agent et le conteneur de l'application, connectés au réseau précédemment créé :

```bash
# Agent Datadog
docker run -d --name datadog-agent \
              --network <NOM_RÉSEAU> \
              -v /var/run/docker.sock:/var/run/docker.sock:ro \
              -v /proc/:/host/proc/:ro \
              -v /sys/fs/cgroup/:/host/sys/fs/cgroup:ro \
              -e DD_API_KEY=<VOTRE_CLÉ_API> \
              -e DD_APM_ENABLED=true \
              -e DD_APM_NON_LOCAL_TRAFFIC=true \
              datadog/agent:latest

# Application
docker run -d --name app \
              --network <NOM_RÉSEAU> \
              company/app:latest
```

Cela expose le hostname `datadog-agent` dans votre conteneur `app`.
Si vous utilisez `docker-compose`, les paramètres `<NOM_RÉSEAU>` correspondent aux paramètres définis dans la section `networks` de votre fichier `docker-compose.yml`.

Vos traceurs d'application doivent être configurés afin d'envoyer des traces à cette adresse. Définissez les variables d'environnement en indiquant le `DD_AGENT_HOST` en tant que nom de conteneur de l'Agent et le `DD_TRACE_AGENT_PORT` en tant port des traces de l'Agent dans vos conteneurs d'application. Dans cet exemple, il s'agit respectivement de `datadog-agent` et de `8126`.

Vous pouvez également consulter les exemples ci-dessous pour définir manuellement le host de l'Agent dans chaque langage pris en charge.

{{< tabs >}}
{{% tab "Java" %}}
Mettez à jour la configuration de l'Agent Java avec des variables d'environnement…

```bash
DD_AGENT_HOST=datadog-agent \
DD_TRACE_AGENT_PORT=8126 \
java -javaagent:/chemin/vers/l/agent-java-dd.jar -jar /votre/app.jar
```

… ou avec des propriétés système :

```bash
java -javaagent:/chemin/vers/l/agent-java-dd.jar \
     -Ddd.agent.host=datadog-agent \
     -Ddd.agent.port=8126 \
     -jar /votre/app.jar
```
{{% /tab %}}
{{% tab "Python" %}}
```python
from ddtrace import tracer

tracer.configure(
    hostname='datadog-agent',
    port=8126,
)
```
{{% /tab %}}
{{% tab "Ruby" %}}
```ruby
Datadog.configure do |c|
  c.tracer hostname: 'datadog-agent',
           port: 8126
end
```
{{% /tab %}}
{{% tab "Go" %}}
```go
package main

import "gopkg.in/DataDog/dd-trace-go.v1/ddtrace/tracer"

func main() {
    tracer.Start(tracer.WithAgentAddr("datadog-agent:8126"))
    defer tracer.Stop()
}
```
{{% /tab %}}
{{% tab "Node.js" %}}
```javascript
const tracer = require('dd-trace').init({
  hostname: 'datadog-agent',
  port: 8126
})
```
{{% /tab %}}
{{< /tabs >}}

### IP de host Datadog

Le port de conteneur de l'Agent `8126` doit être associé directement au host.
Configurez votre traceur d'application afin d'indiquer l'itinéraire par défaut de ce conteneur (utilisez la commande `ip route`).

L'exemple suivant est basé sur le traceur Python et part du principe que `172.17.0.1` est votre itinéraire par défaut :

```python
from ddtrace import tracer

tracer.configure(hostname='172.17.0.1', port=8126)
```

## Pour aller plus loin

{{< partial name="whats-next/whats-next.html" >}}

[1]: https://app.datadoghq.com/account/settings#api
[2]: /fr/tracing/trace_search_and_analytics/#automatic-configuration
[3]: /fr/tracing/send_traces