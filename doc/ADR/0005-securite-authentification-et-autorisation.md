# 5. Securite : authentification et autorisation

## Statut
Accepté

## Contexte
Le systeme de gestion de bibliotheque manipule des donnees sensibles :

- informations personnelles des usagers (nom, email, historique d’emprunts),
- droits d’acces differents selon les roles (usager, bibliothecaire, administrateur).

Certaines operations doivent etre limitees :

- seul un usager authentifie peut consulter son propre compte,
- seuls les bibliothecaires peuvent enregistrer des retours, gerer certains aspects du catalogue,
- seuls les administrateurs peuvent gerer les droits ou effectuer certaines operations globales.

Le systeme doit etre accessible via une interface web et potentiellement via une API.

## Decision
Mettre en place un mecanisme d’**authentification** base sur sessions ou JWT (selon le framework selectionne) et un **controle d’acces par roles (RBAC)** au niveau de l’application.

Principes retenus :

- les usagers doivent se connecter pour acceder a leur compte et effectuer des emprunts ou reservations,
- les bibliothecaires et administrateurs disposent de roles specifiques,
- les points d’entree (routes / controllers / endpoints) sont proteges par des regles de controle d’acces declaratives (annotations, configuration de securite, etc.),
- les mots de passe sont stockes de maniere securisee (hachage avec sel).

## Alternatives envisagees
- **Absence d’authentification (acces anonyme)**  
  Rejetee car incompatible avec la protection minimale des donnees des usagers et avec la distinction des roles metier.

- **Authentification limitee au reseau (filtrage IP, VPN uniquement)**  
  Rejetee car ne permet pas de distinguer les differents types d’utilisateurs (usager, bibliothecaire, administrateur) et ne couvre pas le cas d’un acces via internet.

- **Integration immediate avec un fournisseur SSO externe (OAuth2 / OpenID Connect)**  
  Rejetee dans un premier temps pour limiter la complexite technique et la dependance a un fournisseur externe.  
  Cette option reste envisageable plus tard en complement ou remplacement du mecanisme local.

## Consequences
- **Positives**
  - Protection des donnees personnelles des usagers.
  - Controle fin des operations autorisees pour chaque role.
  - Compatibilite avec une future exposition d’une API (les mecanismes de tokens/JWT sont standard).
  - Possibilite d’ajouter plus tard une integration SSO sans remettre en cause tout le modele d’autorisation.

- **Negatives**
  - Complexite supplementaire : gestion des sessions ou tokens, expiration, renouvellement, securisation du stockage des mots de passe.
  - Necessite de mettre en place des bonnes pratiques de securite complementaires (journalisation des actions sensibles, protection contre la force brute, etc.).
  - Impact sur l’experience utilisateur (obligation de se connecter).

Cette decision complete l’**architecture generale** (ADR-0001) et aura un impact sur le design de l’interface utilisateur et des API.
