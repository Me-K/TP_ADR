# 3. Gestion des transactions

## Statut
Accepté

## Contexte
Les operations critiques du systeme incluent :

- l’emprunt d’un exemplaire,
- la reservation d’un exemplaire,
- le retour d’un exemplaire,
- la mise a jour des stocks et des disponibilites.

Ces operations doivent rester coherentes meme :

- en cas de concurrence (plusieurs usagers agissent en meme temps),
- en cas d’erreur applicative ou de panne,
- lorsque plusieurs tables sont modifiees dans une seule operation metier.

## Decision
Utiliser des **transactions ACID** gerees par PostgreSQL, pilotees via un **ORM** dans la couche applicative (par exemple JPA/Hibernate ou equivalent).  

Principes retenus :

- les transactions sont demarrees et terminees au niveau des cas d’usage (services applicatifs),
- chaque operation metier critique (emprunt, reservation, retour) est encapsulee dans une transaction,
- l’ORM gere automatiquement le demarrage, la validation (commit) ou l’annulation (rollback) des transactions,
- des mecanismes de verrouillage (optimiste via versioning, ou pessimiste si necessaire) sont utilises pour eviter les incoherences.

## Alternatives envisagees
- **Gestion manuelle des transactions via JDBC / SQL brut**  
  Rejetee car plus verbeuse et sujette aux erreurs (oublis de commit/rollback, gestion d’exceptions compliquee).  
  L’utilisation d’un ORM standardise le comportement et simplifie la maintenance.

- **Architecture orientee evenements avec coherences eventual (eventual consistency)**  
  Rejetee comme strategie principale car la coherence forte est prioritaire dans ce systeme (un exemplaire ne peut pas etre emprunte deux fois).  
  Une approche a base d’evenements pourra etre envisagee plus tard pour certaines integrations, mais pas pour la gestion interne des emprunts/reservations.

- **Transactions distribuees (2PC) entre plusieurs bases ou services**  
  Rejetees pour l’instant car l’architecture est monolithique, avec une seule base principale. La complexite des protocoles de coordination n’est pas justifiee.

## Consequences
- **Positives**
  - Coherence forte des donnees pour les operations critiques.
  - Reduction du risque d’anomalies (double emprunt, reservation incorrecte, etc.).
  - Simplification de la logique applicative grace a l’ORM et aux annotations de transaction.

- **Negatives**
  - Risque de contention sur certaines tables en cas de forte charge si les transactions sont trop longues.
  - Necessite de concevoir les cas d’usage pour limiter la duree des transactions (pas d’appels reseau lents a l’interieur, par exemple).
  - La cohérence forte peut limiter certaines optimisations de performance.

Cette decision s’appuie sur le **choix de PostgreSQL** (voir ADR-0002) et sur l’**architecture monolithique** (voir ADR-0001).
