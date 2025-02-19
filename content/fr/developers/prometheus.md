---
title: Écrire un check OpenMetrics personnalisé
kind: documentation
further_reading:
  - link: agent/prometheus
    tag: Documentation
    text: Configurer un check OpenMetrics
  - link: developers/agent_checks
    tag: Documentation
    text: Écrire un check custom
  - link: developers/integrations/
    tag: Documentation
    text: Créer une intégration
aliases:
  - /fr/developers/openmetrics/
---
## Présentation

Cette page présente l'interface `OpenMetricsBaseCheck` en détail pour une utilisation plus avancée, avec notamment un exemple de check simple qui recueille des métriques de temps et des événements de statut depuis [Kube DNS][1]. Pour en savoir plus sur la configuration d'un check OpenMetrics de base, consultez la [documentation relative à l'Agent][2].

## Utilisation avancée : interface de check OpenMetrics

Si vous avez besoin de fonctionnalités plus avancées que celles offertes par le check générique (telles que le prétraitement de métriques), vous pouvez écrire un `OpenMetricsBaseCheck` personnalisé. Il s'agit de [la classe de base][3] du check générique, qui fournit une structure et certains auxiliaires permettant de recueillir des métriques, des événements et des checks de service exposés via Prometheus. Les checks basés sur cette classe nécessitent d'effectuer les opérations de configuration suivantes :

- Remplacement de `self.NAMESPACE`
- Remplacement de `self.metrics_mapper`
- Implémentation de la méthode `check()`
ET/OU
- Création d'une méthode portant le nom de la métrique OpenMetric gérée par les checks (voir `self.prometheus_metric_name`)

## Écrire un check Prometheus custom

Voici un exemple simple de check Kube DNS écrit afin d'illustrer l'utilisation de la classe `OpenMetricsBaseCheck`. L'exemple ci-dessous reproduit les fonctionnalités du check Prometheus générique suivant :

```yaml
instances:
  - prometheus_url: http://localhost:10055/metrics
    namespace: "kubedns"
    metrics:
      - kubedns_kubedns_dns_response_size_bytes: response_size.bytes
      - kubedns_kubedns_dns_request_duration_seconds: request_duration.seconds
      - kubedns_kubedns_dns_request_count_total: request_count
      - kubedns_kubedns_dns_error_count_total: error_count
      - kubedns_kubedns_dns_cachemiss_count_total: cachemiss_count
```

### Configuration

<div class="alert alert-warning">
Vos fichiers de configuration et de check doivent porter le même nom. Si votre check s'appelle <code>moncheck.py</code>, votre fichier de configuration <em>doit</em> s'appeler <code>moncheck.yaml</code>.
</div>

La configuration d'un check Prometheus est pratiquement la même que celle d'un [check de l'Agent][4] classique. La principale différence est l'inclusion de la variable `prometheus_endpoint` dans votre fichier `check.yaml`. Le code suivant doit être ajouté dans `conf.d/kube_dns.yaml` :

```yaml
init_config:

instances:
    # URL de l'endpoint des métriques de Prometheus
  - prometheus_endpoint: http://localhost:10055/metrics
```

### Écrire le check
Tous les checks OpenMetrics héritent de la classe `OpenMetricsBaseCheck` qui se trouve dans `checks/openmetrics_check.py` :

```python
from datadog_checks.checks.openmetrics import OpenMetricsBasicCheck

class KubeDNSCheck(OpenMetricsBasicCheck):
```

#### Remplacement de `self.NAMESPACE`

`NAMESPACE` correspond au préfixe des métriques. Il doit être codé en dur dans la classe de votre check :

```python
from datadog_checks.checks.openmetrics import OpenMetricsBaseCheck

class KubeDNSCheck(OpenMetricsBaseCheck):
    def __init__(self, name, init_config, agentConfig, instances=None):
        super(KubeDNSCheck, self).__init__(name, init_config, agentConfig, instances)
        self.NAMESPACE = 'kubedns'
```

#### Remplacement de `self.metrics_mapper`

`metrics_mapper` est un dictionnaire où la clé est la métrique à recueillir et la valeur est le nom de métrique correspondant dans Datadog.
L'objectif du remplacement est de faire en sorte que les métriques envoyées par les checks OpenMetrics ne soient pas considérées comme des [métriques custom][5] :

```python
from datadog_checks.checks.openmetrics import OpenMetricsBaseCheck

class KubeDNSCheck(OpenMetricsBaseCheck):
    def __init__(self, name, init_config, agentConfig, instances=None):
        super(KubeDNSCheck, self).__init__(name, init_config, agentConfig, instances)
        self.NAMESPACE = 'kubedns'
        self.metrics_mapper = {
            #Les métriques ont été renommées par kubedns dans kubernetes 1.6.0
            'kubedns_kubedns_dns_response_size_bytes': 'response_size.bytes',
            'kubedns_kubedns_dns_request_duration_seconds': 'request_duration.seconds',
            'kubedns_kubedns_dns_request_count_total': 'request_count',
            'kubedns_kubedns_dns_error_count_total': 'error_count',
            'kubedns_kubedns_dns_cachemiss_count_total': 'cachemiss_count'
        }
```

#### Implémenter la méthode de check

Depuis `instance`, utilisez `endpoint`, qui correspond à l'endpoint de métriques Prometheus ou OpenMetrics à partir duquel les métriques sont récupérées :

```python
def check(self, instance):
    endpoint = instance.get('prometheus_endpoint')
```

##### Exceptions

Si un check ne parvient pas à se lancer en raison d'une mauvaise configuration ou d'une erreur de programmation, ou s'il n'est pas en mesure de recueillir de métrique, il doit générer une exception explicative. Cette exception est loguée et affichée dans la [commande status][6] de l'Agent pour faciliter le debugging. Par exemple :

    $ sudo /etc/init.d/datadog-agent info

      Checks
      ======

        my_custom_check
        ---------------
          - instance #0 [ERROR]: Unable to find prometheus_endpoint in config file.
          - Collected 0 metrics & 0 events

Améliorez votre méthode `check ()` avec `CheckException` :

```python
from datadog_checks.errors import CheckException

def check(self, instance):
    endpoint = instance.get('prometheus_endpoint')
    if endpoint is None:
        raise CheckException("Unable to find prometheus_endpoint in config file.")
```

Ensuite, les données sont transmises dès qu'elles sont disponibles :

```python
from datadog_checks.errors import CheckException

def check(self, instance):
    endpoint = instance.get('prometheus_endpoint')
    if endpoint is None:
        raise CheckException("Unable to find prometheus_endpoint in config file.")
    # Par défaut, nous envoyons les compartiments.
    if send_buckets is not None and str(send_buckets).lower() == 'false':
        send_buckets = False
    else:
        send_buckets = True

    self.process(endpoint, send_histograms_buckets=send_buckets, instance=instance)
```

### Synthèse

```python
from datadog_checks.errors import CheckException
from datadog_checks.checks.openmetrics import OpenMetricsBaseCheck

class KubeDNSCheck(OpenMetricsBaseCheck):
    """
    Collect kube-dns metrics from Prometheus endpoint
    """
    def __init__(self, name, init_config, agentConfig, instances=None):
        super(KubeDNSCheck, self).__init__(name, init_config, agentConfig, instances)
        self.NAMESPACE = 'kubedns'

        self.metrics_mapper = {
            # les métriques ont été renommées par kubedns dans kubernetes 1.6.0
            'kubedns_kubedns_dns_response_size_bytes': 'response_size.bytes',
            'kubedns_kubedns_dns_request_duration_seconds': 'request_duration.seconds',
            'kubedns_kubedns_dns_request_count_total': 'request_count',
            'kubedns_kubedns_dns_error_count_total': 'error_count',
            'kubedns_kubedns_dns_cachemiss_count_total': 'cachemiss_count',
        }

    def check(self, instance):
        endpoint = instance.get('prometheus_endpoint')
        if endpoint is None:
            raise CheckException("Unable to find prometheus_endpoint in config file.")

        send_buckets = instance.get('send_histograms_buckets', True)
        # Par défaut, nous envoyons les compartiments.
        if send_buckets is not None and str(send_buckets).lower() == 'false':
            send_buckets = False
        else:
            send_buckets = True

        self.process(endpoint, send_histograms_buckets=send_buckets, instance=instance)
```

## Concepts avancés

Vous pouvez améliorer votre check OpenMetrics à l'aide des méthodes suivantes :

### `self.ignore_metrics`

Certaines métriques sont ignorées car elles sont en double ou introduisent une très forte cardinalité. Les métriques incluses dans cette liste seront ignorées en silence, sans que la ligne de debugging `Unable to handle metric` ne soit ajoutée dans les logs.

### `self.labels_mapper`

Si le dictionnaire `labels_mapper` est fourni, les étiquettes de métriques dans `labels_mapper` utilisent la valeur correspondante comme nom de tag lors de l'envoi des gauges.

### `self.exclude_labels`

`exclude_labels` est un tableau d'étiquettes à exclure. Ces étiquettes ne seront pas ajoutées en tant que tags lors de l'envoi de la métrique.

### `self.type_overrides`


`type_overrides` est un dictionnaire où les clés correspondent aux noms des métriques Prometheus ou OpenMetrics et où les valeurs correspondent au type de métrique (nom sous forme de chaîne) à utiliser au lieu de celui indiqué dans la charge utile. Il peut être utilisé pour forcer l'application d'un type sur des métriques non associées à un type. 
Voici les types disponibles : `counter`, `gauge`, `summary`, `untyped` et `histogram`.

**Remarque**‭ : cette valeur est vide dans la classe de base, mais doit être surchargée/codée en dur dans le check final pour que les métriques ne soient pas considérées comme des métriques custom.

## Pour aller plus loin

{{< partial name="whats-next/whats-next.html" >}}

[1]: https://github.com/DataDog/integrations-core/blob/master/kube_dns/datadog_checks/kube_dns/kube_dns.py
[2]: /fr/agent/prometheus
[3]: https://github.com/DataDog/dd-agent/blob/master/checks/prometheus_check.py
[4]: /fr/agent/agent_checks/#configuration
[5]: /fr/developers/metrics/custom_metrics
[6]: /fr/agent/guide/agent-commands/#agent-status-and-information