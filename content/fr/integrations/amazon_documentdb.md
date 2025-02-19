---
categories:
  - cloud
  - data store
  - aws
  - collecte de logs
ddtype: crawler
dependencies: []
description: "Surveillez vos métriques et vos logs AWS\_DocumentDB."
doc_link: 'https://docs.datadoghq.com/integrations/amazon_documentdb/'
further_reading:
  - link: 'https://www.datadoghq.com/blog/monitor-documentdb-with-datadog/'
    tag: Blog
    text: "Recueillez des métriques et des logs Amazon\_DocumentDB avec Datadog"
git_integration_title: amazon_documentdb
has_logo: true
integration_title: "Amazon\_DocumentDB"
is_public: true
kind: intégration
manifest_version: 1
name: amazon_documentdb
public_title: "Intégration Datadog/Amazon\_DocumentDB"
short_description: "Surveillez vos métriques et vos logs AWS\_DocumentDB."
version: 1
---
## Présentation

Amazon DocumentDB est un service de base de données de documents rapide, scalable, hautement disponible et entièrement géré qui prend en charge les charges de travail MongoDB.

## Implémentation
### Installation

Si vous ne l'avez pas déjà fait, configurez d'abord [l'intégration Amazon Web Services][1].

### Collecte de métriques

1. Dans le [carré d'intégration AWS][2], assurez-vous que l'option `DocumentDB` est cochée dans la section sur la collecte de métriques.

2. Installez l'[intégration Datadog/AWS DocumentDB][3].

### Collecte de logs

1. Si vous ne l'avez pas déjà fait, configurez [la fonction Lambda de collecte de logs AWS avec Datadog][4].
2. Une fois la fonction Lambda installée, ajoutez manuellement un déclencheur dans la console AWS sur le groupe de logs CloudWatch qui contient vos logs DocumentDB. 
Consultez la section [Configurer manuellement des déclencheurs][5] dans la documentation sur AWS.

Accédez ensuite à la [section Log de Datadog][6] pour commencer à explorer vos logs !

## Données collectées
### Métriques
{{< get-metrics-from-git "amazon_documentdb" >}}


Chacune des métriques récupérées à partir d'AWS se voit assigner les mêmes tags que ceux qui apparaissent dans la console AWS, y compris, mais sans s'y limiter, dbinstanceidentifier et dbclusteridentifier.

### Événements
L'intégration AWS DocumentDB n'inclut aucun événement.

### Checks de service
L'intégration AWS DocumentDB n'inclut aucun check de service.

## Dépannage
Besoin d'aide ? Contactez [l'assistance Datadog][8].

## Pour aller plus loin

{{< partial name="whats-next/whats-next.html" >}}

[1]: https://docs.datadoghq.com/fr/integrations/amazon_web_services
[2]: https://app.datadoghq.com/account/settings#integrations/amazon_web_services
[3]: https://app.datadoghq.com/account/settings#integrations/amazon_documentdb
[4]: https://docs.datadoghq.com/fr/integrations/amazon_web_services/#create-a-new-lambda-function
[5]: https://docs.datadoghq.com/fr/integrations/amazon_web_services/#manually-setup-triggers
[6]: https://app.datadoghq.com/logs
[7]: https://github.com/DataDog/dogweb/blob/prod/integration/amazon_documentdb/amazon_documentdb_metadata.csv
[8]: https://docs.datadoghq.com/fr/help


{{< get-dependencies >}}