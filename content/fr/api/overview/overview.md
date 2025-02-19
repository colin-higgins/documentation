---
title: Présentation
type: apicontent
order: 1
external_redirect: '/api/#presentation'
---
## Présentation
Cette section décrit l'API HTTP de Datadog afin de transmettre des données vers et depuis Datadog.

**Pour débuter sur l'API HTTP Datadog, utilisez notre [collection Postman de Datadog][1]**

L'API Datadog utilise des URL orientées ressources, applique des codes de statut afin d'indiquer la réussite ou l'échec des requêtes et renvoie un objet JSON à partir de toutes les requêtes. Rentrons dans le vif du sujet et découvrons son fonctionnement.

**Remarque** : les exemples de code cURL supposent que vous utilisiez les coreutils GNU et BASH. Sous macOS, vous pouvez installer coreutils via le [gestionnaire de paquets Homebrew][2] : `brew install coreutils`.

[1]: /fr/getting_started/api
[2]: https://brew.sh