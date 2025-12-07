# Rapport – TP ADR

## Partie 1 : Étude théorique

### 1. Qu’est-ce qu’un ADR ? Quels sont ses avantages par rapport à une documentation classique ?

Un ADR (Architecture Decision Record) est un document court qui décrit une décision d’architecture logicielle importante.  
Il précise le contexte dans lequel la décision a été prise, la solution retenue, les alternatives envisagées et les conséquences de ce choix.

Par rapport à une documentation classique (gros documents d’architecture, wiki peu structuré, etc.), les ADR présentent plusieurs avantages :

- Ils sont **fins et ciblés** : chaque ADR se concentre sur une seule décision, ce qui facilite la lecture et la recherche.
- Ils offrent une **bonne traçabilité** : on peut suivre l’historique des décisions et voir quand et pourquoi elles ont été prises ou modifiées.
- Ils sont **proches du code** : comme ils sont stockés dans le dépôt Git du projet, ils évoluent en même temps que le code.
- Ils sont **simples à maintenir** : ce sont de simples fichiers texte (souvent en Markdown), faciles à écrire, relire et versionner.
- Ils rendent les **compromis explicites** : le fait de documenter le contexte, les alternatives et les conséquences aide à comprendre le raisonnement de l’équipe.

### 2. Citez trois outils ou méthodes pour gérer les ADR. Comparez-les.

1. **Fichiers Markdown dans le dépôt**

Les ADR sont écrits à la main dans des fichiers `.md`, rangés dans un dossier comme `doc/adr`.

- Avantages : très simple à mettre en place, aucun outil supplémentaire, fonctionne partout, intégré naturellement au versionnement Git.
- Inconvénients : aucun contrôle automatique sur la structure ou la numérotation, risque d’incohérences si l’équipe ne suit pas de règles communes.

2. **adr-tools**

`adr-tools` est un outil en ligne de commande qui aide à créer et gérer les ADR (génération de fichiers, numérotation, etc.).

- Avantages : fournit un template standard, gère automatiquement la numérotation, facilite la création et listage des ADR.
- Inconvénients : nécessite une installation et un apprentissage minimal, ajoute une dépendance de plus à l’environnement de développement.

3. **Documentation générée (MkDocs, Docusaurus, etc.)**

Les ADR restent des fichiers Markdown, mais un outil comme MkDocs ou Docusaurus génère un site web pour les consulter.

- Avantages : rend la lecture plus agréable (site web), facilité de navigation, recherche plein texte, intégration avec le reste de la documentation.
- Inconvénients : nécessite une étape de build, une configuration supplémentaire, et peut être surdimensionné pour les petits projets.

### 3. Pourquoi est-il important de documenter les alternatives et les conséquences d’une décision architecturale ?

Documenter les **alternatives** permet de garder une trace des autres solutions qui ont été envisagées et des raisons pour lesquelles elles ont été rejetées.  
Cela évite de reposer indéfiniment les mêmes questions et permet aux nouveaux membres de l’équipe de comprendre que certains choix ont déjà été étudiés.

Documenter les **conséquences** rend explicites les compromis associés à la décision : impacts sur les performances, la sécurité, la maintenabilité, la complexité, etc.  
Cela aide à anticiper les risques, à expliquer les problèmes éventuels (“on a choisi X en acceptant telle limitation”) et à décider plus facilement quand il est nécessaire de revisiter une décision.

### 4. Quels sont les risques liés à une mauvaise gestion des décisions d’architecture ?

Une mauvaise gestion des décisions d’architecture peut entraîner plusieurs risques :

- **Perte de connaissance** : si les décisions ne sont pas documentées, elles disparaissent lorsque les personnes qui les ont prises quittent le projet, entrainant des soucis de maintenabilité
- **Incohérences dans le système** : différentes équipes peuvent prendre des décisions contradictoires (outils, frameworks, styles d’architecture), ce qui complique l’intégration.
- **Dette architecturale invisible** : des compromis importants comme les contournements ou les choix “temporaires” ne sont pas rendus explicites et s’accumulent sans être gérés.
- **Régressions** : sans trace des contraintes initiales, des modifications ultérieures peuvent casser des propriétés non fonctionnelles (performance, sécurité, fiabilité).
- **Conflits et discussions répétées** : les mêmes débats reviennent régulièrement car il n’y a pas de référence claire sur les choix déjà tranchés.

## Partie 2 - 3 :

Voir github : [Répo Github](https://github.com/Me-K/TP_ADR)

## Partie 4 : Analyse et discussion

### 1. Avantages et limites des ADR pour notre projet

Dans le cadre de notre systeme de gestion de bibliotheque, les ADR apportent plusieurs avantages importants.

Tout d’abord, ils permettent de conserver une **trace claire et structuree des decisions d’architecture** telles que le choix de l’architecture generale, de la base de donnees, de la gestion des transactions, des notifications et de la securite. Cela facilite la comprehension du projet, notamment pour une personne qui rejoint l’equipe plus tard.

Ensuite, les ADR rendent les **choix techniques explicites et justifies**, grace a la description du contexte, des alternatives envisagees et des consequences. On ne sait pas seulement “ce qui a ete choisi”, mais aussi “pourquoi”.

Le fait que les ADR soient **versionnes avec Git** est egalement un grand avantage. Ils evoluent en meme temps que le code et sont directement lies a l’historique du projet.

Enfin, dans notre cas, l’integration d’un **script de verification et d’une CI GitHub Actions** permet d’assurer automatiquement que tous les ADR respectent bien le format impose.

Cependant, les ADR presentent aussi certaines limites.

Ils demandent un **temps de redaction supplementaire**, ce qui peut paraitre contraignant pour de petits projets ou des equipes avec peu de temps.

De plus, si les ADR ne sont **pas mis a jour** lorsque l’architecture evolue, ils peuvent devenir obsoletes et ne plus refleter la realite du systeme.

Enfin, les ADR ne remplacent pas completement une **documentation d’architecture globale** (diagrammes, vues d’ensemble). Ils documentent les decisions, mais pas toute la structure detaillee du systeme.

### 2. Automatisation de la gestion des ADR

Dans notre projet, une premiere etape d’automatisation a deja ete mise en place grace a un **script de verification des ADR** et a un **workflow GitHub Actions**.  
A chaque push ou pull request, le script verifie automatiquement que tous les fichiers ADR contiennent bien les sections obligatoires du template. Cela permet d’eviter les erreurs de format et d’assurer une coherence minimale.

D’autres automatisations pourraient etre ajoutees, par exemple :

- Un **bot GitHub** qui verifie automatiquement qu’une pull request modifiant l’architecture contient un nouvel ADR ou une mise a jour d’un ADR existant.
- La **generation automatique d’un index des ADR**, a partir des titres des fichiers, pour faciliter la navigation.
- L’ajout automatique de **labels** dans GitHub (par exemple “architecture change”) lorsqu’un fichier du dossier `doc/adr` est modifie.

Ces automatisations permettraient de renforcer encore la qualite et le suivi des decisions d’architecture.

### 3. Amelioration du processus de redaction des ADR

Une amelioration interessante du processus de redaction des ADR serait de mettre en place une **revue systematique des ADR** avant leur validation.

Concretement, toute nouvelle decision d’architecture devrait :
- etre relue par au moins un autre membre de l’equipe,
- verifier que le contexte est clair,
- qu’au moins deux alternatives sont bien decrites,
- et que les consequences positives et negatives sont explicites.

On pourrait egalement ajouter un champ “References” dans les ADR pour faire le lien avec les **issues, tickets ou user stories** associes a la decision. Cela renforcerait encore la tracabilite entre les besoins fonctionnels et les choix d’architecture.
