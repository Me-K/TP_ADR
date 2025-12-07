# 2. Choix de la base de donnees

## Statut
Accepté

## Contexte
Le systeme doit gerer :

- un grand nombre d’operations d’emprunt, de reservation et de retour,
- une forte coherence des donnees (un exemplaire ne peut pas etre emprunte par deux usagers en meme temps),
- des requetes de consultation et de statistiques (historique des emprunts, disponibilite des ouvrages, etc.).

Nous avons besoin :

- de **transactions fiables (ACID)**,
- de **contraintes d’integrite** (cles etrangeres, unicite),
- d’un langage de requete expressif.

## Decision
Utiliser **PostgreSQL** comme base de donnees relationnelle principale.

Le schema sera modelise de maniere relationnelle (tables pour les exemplaires, livres, usagers, emprunts, reservations, etc.), avec des cles etrangeres et des contraintes pour assurer la coherence.

## Alternatives envisagees
- **MySQL / MariaDB**  
  Rejetee pour ce projet meme si c’est aussi une base relationnelle mature.  
  PostgreSQL est retenu car il offre des fonctionnalites avancees utiles pour des evolutions possibles (types JSONB, vues materialisees, gestion fine des index, fonctions stockees puissantes).

- **MongoDB (NoSQL document)**  
  Rejetee car moins adaptee pour les transactions complexes multi-documents et la gestion stricte des contraintes d’integrite referentielle requises pour les emprunts/reservations.

- **Base NoSQL cle-valeur (ex : Redis comme stockage principal)**  
  Rejetee comme base principale car non adaptee a un modele fortement structure, avec relations et contraintes. Redis pourra eventuellement etre utilise comme cache, mais pas comme stockage de reference.

## Consequences
- **Positives**
  - Coherence transactionnelle garantie (ACID) pour les operations critiques.
  - Support natif des contraintes relationnelles (cles etrangeres, contraintes d’unicite).
  - Utilisation de SQL pour exprimer des requetes complexes et des rapports.
  - Base de donnees largement supportee et documentee, facilitant l’exploitation et le support.

- **Negatives**
  - Necessite de bien concevoir et faire evoluer le schema pour eviter les problemes de performance.
  - Peut etre plus lourde a administrer que certaines solutions NoSQL simples dans des contextes tres simples.
  - Moins flexible que certains stockages schema-less pour des objets tres heterogenes.

Cette decision est coherente avec l’**architecture monolithique modulaire** (voir ADR-0001) et conditionne la **gestion des transactions** (voir ADR-0003).
