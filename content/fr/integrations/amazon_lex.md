---
categories:
  - cloud
  - aws
  - log collection
ddtype: crawler
dependencies: []
description: "Surveillez des métriques clés d'Amazon\_Lex."
doc_link: 'https://docs.datadoghq.com/integrations/amazon_lex/'
git_integration_title: amazon_lex
has_logo: true
integration_title: "Amazon\_Lex"
is_public: true
kind: integration
manifest_version: 1
name: amazon_lex
public_title: "Intégration Datadog/Amazon\_Lex"
short_description: "Surveillez des métriques clés d'Amazon\_Lex."
version: 1
---
## Présentation
Amazon Lex est un service permettant de créer des interfaces de conversation dans une application reposant sur la voix et le texte.

Activez cette intégration pour visualiser dans Datadog toutes vos métriques de Lex.

## Implémentation
### Installation
Si vous ne l'avez pas déjà fait, configurez d'abord [l'intégration Amazon Web Services][1].

### Collecte de métriques
1. Dans le [carré d'intégration AWS][2], assurez-vous que l'option `Lex` est cochée dans la section concernant la collecte des métriques.

2. Installez l'[intégration Datadog/Amazon Lex][3].

### Collecte de logs
#### Activer le logging

Configurez Amazon Lex de façon à ce que ses logs soient envoyés vers un compartiment S3 ou vers Cloudwatch. Assurez-vous d'inclure `amazon_lex` dans le préfixe.

#### Envoyer des logs à Datadog

1. Si vous ne l'avez pas déjà fait, configurez la [fonction Lambda de collecte de logs AWS avec Datadog][4].
2. Une fois la fonction Lambda installée, ajoutez manuellement un déclencheur dans la console AWS sur le groupe de logs Cloudwatch qui contient vos logs Amazon Lex dans la console AWS :

    * [Ajouter un déclencheur manuel sur le compartiment S3][5]
    * [Ajouter un déclencheur manuel sur le groupe de logs Cloudwatch][6]

## Données collectées
### Métriques
{{< get-metrics-from-git "amazon_lex" >}}


### Events
L'intégration Amazon Lex n'inclut aucun événement.

### Checks de service
L'intégration Amazon Lex n'inclut aucun check de service.

## Dépannage
Besoin d'aide ? Contactez [l'assistance Datadog][8].

[1]: https://docs.datadoghq.com/fr/integrations/amazon_web_services
[2]: https://app.datadoghq.com/account/settings#integrations/amazon_web_services
[3]: https://app.datadoghq.com/account/settings#integrations/amazon-lex
[4]: https://docs.datadoghq.com/fr/integrations/amazon_web_services/?tab=allpermissions#create-a-new-lambda-function
[5]: https://docs.datadoghq.com/fr/integrations/amazon_web_services/?tab=allpermissions#collecting-logs-from-s3-buckets
[6]: https://docs.datadoghq.com/fr/integrations/amazon_web_services/?tab=allpermissions#collecting-logs-from-cloudwatch-log-group
[7]: https://github.com/DataDog/dogweb/blob/prod/integration/amazon_lex/amazon_lex_metadata.csv
[8]: https://docs.datadoghq.com/fr/help


{{< get-dependencies >}}