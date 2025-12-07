# 1. Architecture generale du systeme

## Statut
Accepté

## Contexte
Le systeme de gestion de bibliotheque doit gerer les emprunts, les reservations et l’envoi de notifications aux usagers.
Il doit etre fiable (coherence des emprunts et des disponibilites), maintenable (faciliter les evolutions) et reasonably scalable.
L’equipe de developpement est de taille reduite et le delai de mise en production est limite.

Nous devons choisir une architecture generale (monolithe, microservices, etc.) adaptee a ce contexte, qui ne soit pas inutilement complexe mais qui reste evolutive.

## Decision
Nous adoptons une **architecture monolithique modulaire**, avec une separation claire entre :

- la couche de presentation (API REST / UI),
- la couche applicative (cas d’usage),
- la couche domaine (modele metier),
- la couche infrastructure (base de donnees, envoi de mails, etc.).

Les fonctionnalites principales (emprunts, reservations, notifications, gestion des usagers) sont organisees en modules internes bien separes au sein d’une meme application deploiable.

## Alternatives envisagees
- **Architecture microservices**  
  Rejetee car elle introduit une complexite importante (deploiement, communication inter-services, observabilite, gestion des donnees distribuees) qui n’est pas justifiee pour la taille du projet et de l’equipe.  
  De plus, le domaine fonctionnel est encore en evolution et un decoupage fin en services independants serait difficile a stabiliser.

- **Application monolithique sans modularisation claire**  
  Rejetee car elle risque de conduire a un fort couplage entre les parties du systeme (“big ball of mud”), rendant la maintenance et l’evolution tres difficiles.  
  Les changements dans une zone du code pourraient avoir des effets de bord non maitrises dans d’autres modules.

## Consequences
- **Positives**
  - Simplicite de deploiement : un seul artefact a maintenir et a deploier.
  - Cohesion du code : tout le code reste dans un meme depot et un meme projet, ce qui facilite la communication entre developpeurs.
  - Possibilite d’evolution : certains modules pourront etre extraits plus tard vers des services independants si les besoins de scalabilite augmentent.
  - Alignement avec l’organisation de l’equipe (petite equipe, un seul projet principal).

- **Negatives**
  - Scalabilite limitee : il faut scaler l’application complete, meme si un seul module est tres sollicite.
  - Risque de couplage progressif si les regles de modularisation ne sont pas respecte.
  - Certaines decisions techniques (ex. version de framework) impactent tout le systeme.

Cette decision influence notamment le **choix de la base de donnees** (voir ADR-0002) et la **gestion des transactions** (voir ADR-0003).
