---
categories:
  - cloud
  - aws
ddtype: crawler
dependencies: []
description: "Surveillez des métriques clés d'Amazon\_EC2\_Spot."
doc_link: 'https://docs.datadoghq.com/integrations/amazon_ec2_spot/'
git_integration_title: amazon_ec2_spot
has_logo: true
integration_title: "Amazon\_EC2\_Spot"
is_public: true
kind: integration
manifest_version: 1
name: amazon_ec2_spot
public_title: "Intégration Datadog/Amazon\_EC2\_Spot"
short_description: "Surveillez des métriques clés d'Amazon\_EC2\_Spot."
version: 1
---
## Présentation
Les instances Amazon EC2 Spot vous permettent de tirer parti des capacités de calcul EC2 non utilisées dans le cloud AWS.

Activez cette intégration pour visualiser dans Datadog toutes vos métriques d'EC2 Spot.

## Implémentation
### Installation
Si vous ne l'avez pas déjà fait, configurez d'abord [l'intégration Amazon Web Services][1].

### Collecte de métriques
1. Dans le [carré d'intégration AWS][2], assurez-vous que l'option `EC2 Spot Fleet` est cochée dans la section concernant la collecte des métriques.

2. Installez l'[intégration Datadog/Amazon EC2 Spot][3].

## Données collectées
### Métriques
{{< get-metrics-from-git "amazon_ec2_spot" >}}


### Événements
L'intégration Amazon EC2 Spot n'inclut aucun événement.

### Checks de service
L'intégration Amazon EC2 Spot n'inclut aucun check de service.

## Dépannage
Besoin d'aide ? Contactez [l'assistance Datadog][5].

[1]: https://docs.datadoghq.com/fr/integrations/amazon_web_services
[2]: https://app.datadoghq.com/account/settings#integrations/amazon_web_services
[3]: https://app.datadoghq.com/account/settings#integrations/amazon-ec2-spot
[4]: https://github.com/DataDog/dogweb/blob/prod/integration/amazon_ec2_spot/amazon_ec2_spot_metadata.csv
[5]: https://docs.datadoghq.com/fr/help/


{{< get-dependencies >}}