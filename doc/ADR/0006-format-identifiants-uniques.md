#6. Format des identifiants uniques des entites

##Statut
Accepte

##Contexte
Le systeme doit identifier de maniere unique plusieurs entites : usagers, livres, exemplaires, emprunts, reservations.
Deux strategies sont courantes :
- identifiants auto-incrementes generes par la base de donnees,
- identifiants uniques universels (UUID) generes par l'application.

Le choix du format d'identifiant peut influencer :
- la migration des donnees,
- la scalabilite,
- la generation de donnees de test,
- l'exposition des identifiants via une API.

##Decision
Adopter des **UUID v4** comme identifiants uniques pour les entites principales.

La generation se fait au niveau de l'application, garantissant l'unicite sans dependance a un compteur en base.

##Alternatives envisagees
- **Identifiants auto-incrementes (entiers)**  
  Rejetes car ils peuvent poser probleme en cas de scalabilite horizontale forte (replication ecriture/ecriture), et exposent des IDs facilement predictibles sur une API publique.

- **UUID v1 (basés sur timestamp + MAC)**  
  Rejetes en raison d’enjeux potentiels de confidentialité (exposition indirecte d’informations reseau ou temporelles).

##Consequences
- **Positives**
  - Identifiants uniques garantis sans dependance a un sequenceur SQL.
  - Meilleure compatibilite avec une scalabilite future.
  - IDs moins predictibles pour l'exposition API publique.
  - Facilite la fusion ou importation de donnees provenant de plusieurs environnements.

- **Negatives**
  - Les UUID sont plus lourds en terme de stockage et d’indexation qu’un entier auto-incremente.
  - Leger impact potentiel sur les performances lors des jointures intensives.
  - Moins lisible pour les humains qu’un entier simple.

Cette decision n’affecte pas les ADR deja en place mais reste coherent avec l’architecture monolithique et les besoins possibles d’évolution du systeme.
