---
categories:
  - Source Control
  - Collaboration
  - issue tracking
ddtype: crawler
dependencies: []
description: Identifiez les commits et pull requests qui affectent les performances de vos services.
doc_link: 'https://docs.datadoghq.com/integrations/github/'
git_integration_title: github
has_logo: true
integration_title: GitHub
is_public: true
kind: integration
manifest_version: '1.0'
name: github
public_title: Intégration Datadog/GitHub
short_description: Identifiez les commits et pull requests qui affectent les performances de vos services.
version: '1.0'
---
{{< img src="integrations/github/git_integration_screen.png" alt="Événement Git" responsive="true" popup="true">}}

## Présentation

Enregistrez vos commits GitHub dans Datadog pour :

  * Surveiller les nouvelles fonctionnalités à partir des changements de code
  * Identifier les nouveaux changements de code entraînant des alertes système ou des échecs de build
  * Discuter des changements de code avec votre équipe dans le flux d'événements Datadog

## Implémentation

### Installation

#### GitHub

1. Accédez à la page *Settings* de votre projet Github.
2. Sélectionnez l'option *Webhooks* dans le menu de navigation sur la gauche.
3. Cliquez sur le bouton *Add Webhook*.

    {{< img src="integrations/github/github_first_steps.png" alt="premières étapes github" responsive="true" popup="true" style="width:80%;">}}

4. Ajoutez cette URL dans le champ *Payload URL*. N'oubliez pas de remplacer `<DATADOG_API_KEY>` par [votre clé d'API Datadog][1] :

    ```
    https://app.datadoghq.com/intake/webhook/github?api_key=<DATADOG_API_KEY>
    ```

5. Définissez *Content Type* sur `application/json`.

    {{< img src="integrations/github/webhook_configuration_2.png" alt="Configuration webhook" responsive="true" popup="true" style="width:80%;">}}

6. Dans la section *Which events would you like to trigger this webhook?*, utilisez l'option *Let me select individual events.* pour choisir ce que vous souhaitez envoyer à Datadog. L'intégration Datadog/GitHub prend en charge :
    * Les push (nouveaux commits)
    * Les créations et suppressions (pour les tags)
    * Les pull requests
    * Les issues
    * Tous les commentaires

#### Datadog

1. Installez l'[intégration Datadog/GitHub][2].
2. Pour chaque référentiel, ajoutez les branches que vous souhaitez surveiller. Si vous souhaitez ajouter tous les référentiels d'un utilisateur ou d'une organisation, utilisez des caractères génériques.
    Par exemple, pour rassembler tous les événements associés à la branche `master` du référentiel DataDog/Documentation :

    {{< img src="integrations/github/github_classic_configuration.png" alt="github configuration classique" responsive="true" popup="true" style="width:50%;">}}

    Si vous souhaitez rassembler tous les événements associés à **l'ensemble** des branches `master` de l'organisation Datadog :

    {{< img src="integrations/github/get_all_branches.png" alt="github toutes les branches" responsive="true" popup="true" style="width:50%;">}}

## Données collectées

Une fois l'intégration terminée, les événements sélectionnés seront ajoutés à votre flux d'événements Datadog. Saisissez `sources:github` dans la barre de recherche en haut à gauche d'un dashboard pour superposer des événements GitHub sur les graphiques.


## Dépannage

Besoin d'aide ? Contactez [l'assistance Datadog][3].

[1]: https://app.datadoghq.com/account/settings#api
[2]: https://app.datadoghq.com/account/settings#integrations/github
[3]: https://docs.datadoghq.com/fr/help


{{< get-dependencies >}}