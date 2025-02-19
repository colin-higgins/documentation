---
title: Créer un dashboard
type: apicontent
order: 8.1
external_redirect: '/api/#creer-un-dashboard'
---
## Créer un dashboard

**ARGUMENTS**:

* **`title`** [*obligatoire*] :
  Titre du dashboard.
* **`widgets`** [*obligatoire*] :
    Liste des widgets à afficher sur le dashboard. Les définitions de widget respectent le format suivant :
    * **`definition`** [*obligatoire*] :
      [Définition du widget.][1]
    * **`id`** [*facultatif*, *valeur par défaut*=**entier généré automatiquement**] :
      ID du widget.
* **`layout_type`** [*obligatoire*] :
  Type de disposition du dashboard. Valeurs possibles : `ordered` (timeboard précédent) ou `free` (disposition du screenboard précédent)
* **`description`** [*facultatif*, *défaut*=**None**] :
  Description du dashboard.
* **`is_read_only`** [*facultatif*, *défaut*=**False**] :
  Définit si ce dashboard est en lecture seule. Si `True`, seul l'auteur et les administrateurs peuvent effectuer des modifications.
* **`notify_list`** [*facultatif*, *défaut*=**None**] :
  Liste des handles des utilisateurs à notifier lorsque des changements sont apportés à ce dashboard.
* **`template_variables`** [*facultatif*, *défaut*=**None**] :
    Liste des template variables pour ce dashboard. Les définitions de template variables respectent le format suivant :
    * **`name`** [*obligatoire*] :
      Nom de la variable.
    * **`default`** [*facultatif*, *défaut*=**None**] :
        Valeur par défaut de la template variable lors du chargement du dashboard.
    * **`prefix`** [*facultatif*, *défaut*=**None**] :
        Préfixe de tag associé à la variable. Seuls les tags avec ce préfixe apparaissent dans la liste déroulante des variables.

[1]: /fr/graphing/widgets