---
aliases:
  - /fr/integrations/awsroute53/
categories:
  - cloud
  - network
  - web
  - aws
  - log collection
ddtype: crawler
dependencies: []
description: "Surveillez des métriques de Route\_53 et vérifiez des checks de santé."
doc_link: 'https://docs.datadoghq.com/integrations/amazon_route53/'
git_integration_title: amazon_route53
has_logo: true
integration_title: "Amazon Route\_53"
is_public: true
kind: integration
manifest_version: '1.0'
name: amazon_route53
public_title: "Intégration Datadog/Amazon Route\_53"
short_description: "Surveillez des métriques de Route\_53 et vérifiez des checks de santé."
version: '1.0'
---
{{< img src="integrations/amazon_route53/route53_graph.png" alt="graph route53" responsive="true" popup="true">}}

## Présentation

AWS Route 53 fournit une solution de gestion de DNS et de trafic ainsi que de surveillance de la disponibilité et des performances grâce à des checks de santé. Vous pouvez visualiser les informations des checks de santé dans Datadog pour fournir du contexte pour d'autres métriques et événements dans vos environnements. Voici un exemple de dashboard de graphique de statut des checks de santé de Route 53 :

Pour plus d'informations sur le reste des services AWS, consultez [le carré AWS][1]

## Implémentation
### Installation

Si vous ne l'avez pas déjà fait, configurez d'abord [l'intégration Amazon Web Services][2].

### Collecte de métriques

1. Dans le [carré d'intégration AWS][3], assurez-vous que l'option `Route53` est cochée dans la section concernant la collecte des métriques.

2. Ajoutez ces autorisations à votre [stratégie IAM Datadog][4] afin de recueillir des métriques d'Amazon Route 53 :

    * `route53:listHealthChecks` : répertorie les checks de santé disponibles.
    * `route53:listTagsForResources` : ajoute des tags personnalisés aux métriques Route 53 CloudWatch.

    Pour en savoir plus sur les stratégies Route 53, consultez [la documentation disponible sur le site d'AWS][5].

3. Installez l'[intégration Datadog/AWS Route 53][6].

**Remarque** : pour recueillir les métriques Amazon Route 53 via CloudWatch, vous devez choisir la région USA Est (Virginie du Nord). Les métriques Amazon Route 53 ne sont pas disponibles si vous sélectionnez une autre région. Cliquez [ici][7] pour en savoir plus.

### Collecte de logs

Configurez Amazon Route 53 pour enregistrer des informations sur les requêtes que reçoit Route 53, telles que :

* Le domaine ou le sous-domaine qui a été demandé
* La date et l'heure de la requête
* Le type d'enregistrement DNS (comme A ou AAAA)
* L'emplacement périphérique de Route 53 qui a répondu à la requête DNS
* Le code de réponse DNS, comme NoError ou ServFail

#### Activer la journalisation Route 53



Accédez à votre console AWS Route 53 et sélectionnez la zone hébergée pour laquelle vous souhaitez configurer la journalisation. Cliquez sur la case d'option et sélectionnez « configure query logging ».
{{< img src="integrations/amazon_route53/amazon_route_53_log_enable.png" alt="activer la journalisation route 53" responsive="true" popup="true" style="width:70%;">}}

Sélectionnez ensuite le groupe de logs Cloudwatch ou créez-en un pour y envoyer les logs. Vérifiez que « route 53 » fait partie du nom du groupe de logs.

#### Envoyer des logs à Datadog

1. Si vous ne l'avez pas déjà fait, configurez la [fonction Lambda de collecte de logs AWS avec Datadog][8].
2. Une fois la fonction Lambda installée, ajoutez manuellement un déclencheur dans la console AWS sur le groupe de logs CloudWatch qui contient vos logs Route 53 :
{{< img src="integrations/amazon_cloudwatch/cloudwatch_log_collection_1.png" alt="groupes de logs cloudwatch" responsive="true" popup="true" style="width:70%;">}}
   Sélectionnez le groupe de logs CloudWatch correspondant, ajoutez un nom de filtre (vous pouvez toutefois laisser le filtre vide) et ajoutez le déclencheur :
{{< img src="integrations/amazon_cloudwatch/cloudwatch_log_collection_2.png" alt="Déclencheur cloudwatch" responsive="true" popup="true" style="width:70%;">}}

Accédez ensuite à la [section Log de Datadog][9] pour commencer à explorer vos logs !


## Données collectées
### Métriques
{{< get-metrics-from-git "amazon_route53" >}}


Chacune des métriques récupérées à partir d'AWS se verra assigner les mêmes tags que ceux qui apparaissent dans la console AWS, y compris, mais sans s'y limiter, le hostname et les groupes de sécurité.

### Événements
L'intégration AWS Route 53 n'inclut aucun événement.

### Checks de service
L'intégration AWS Route 53 n'inclut aucun check de service.

## Dépannage
Besoin d'aide ? Contactez [l'assistance Datadog][11].

[1]: https://docs.datadoghq.com/fr/integrations/amazon_web_services
[2]: https://docs.datadoghq.com/fr/integrations/amazon_web_services
[3]: https://app.datadoghq.com/account/settings#integrations/amazon_web_services
[4]: https://docs.datadoghq.com/fr/integrations/amazon_web_services/#installation
[5]: https://docs.aws.amazon.com/IAM/latest/UserGuide/list_route53.html
[6]: https://app.datadoghq.com/account/settings#integrations/amazon_route53
[7]: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/health-checks-monitor-view-status.html#monitoring-health-checks
[8]: https://docs.datadoghq.com/fr/integrations/amazon_web_services/#create-a-new-lambda-function
[9]: https://app.datadoghq.com/logs
[10]: https://github.com/DataDog/dogweb/blob/prod/integration/amazon_route53/amazon_route53_metadata.csv
[11]: https://docs.datadoghq.com/fr/help


{{< get-dependencies >}}