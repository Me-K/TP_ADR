# 4. Gestion des notifications

## Statut
Accepté

## Contexte
Le systeme doit notifier les usagers pour :

- les rappels avant la date de retour,
- les confirmations d’emprunt ou de reservation,
- la disponibilite d’un livre reserve.

Les notifications sont principalement envoyeess par e-mail, avec une eventuelle extension future a d’autres canaux (SMS, notifications push, etc.).

Les operations metier (emprunt, reservation) ne doivent pas etre ralenties ni echouer a cause d’un probleme de serveur mail ou de reseau.

## Decision
Mettre en place une **gestion asynchrone des notifications**, basee sur :

- la creation d’un enregistrement de notification a envoyer (en base de donnees ou dans une file de messages interne) lors de l’operation metier,
- un composant separer (tache planifiee, worker, consumer) qui lit ces notifications en attente et effectue l’envoi effectif (e-mail, etc.).

Les cas d’usage (emprunt, reservation) se contentent d’ajouter la notification a la queue, puis se terminent sans attendre l’envoi effectif.

## Alternatives envisagees
- **Envoi synchrone des notifications dans la transaction d’emprunt/reservation**  
  Rejete car cela augmente la latence des operations et couples fortement la logique metier au service d’envoi (SMTP, API externe).  
  En cas de panne du service d’e-mail, la transaction metier pourrait echouer alors que l’emprunt devrait etre valide.

- **Traitement uniquement par un batch periodique (cron) sans integration fine avec les operations**  
  Rejete car moins reactif et moins flexible. Un simple batch ne permet pas facilement de gerer des notifications immediates (confirmation) tout en traitant les rappels planifies.

## Consequences
- **Positives**
  - Decouplage entre la logique metier et le mecanisme d’envoi des notifications.
  - Amelioration de la reactivite pour l’utilisateur : l’emprunt/reservation est validee sans attendre que l’e-mail soit envoye.
  - Possibilite d’ajouter facilement de nouveaux canaux de notification en reutilisant le meme mecanisme de queue.

- **Negatives**
  - Complexite supplementaire : il faut gerer le statut des notifications (en attente, en cours, reussi, echec) et les eventuelles tentatives de renvoi.
  - Necessite de surveiller le composant de traitement des notifications (monitoring, logs).
  - Eventuelle legere latence entre l’action de l’utilisateur et la reception de la notification.

Cette decision s’inscrit dans le **monolithe modulaire** (voir ADR-0001) et interagit avec la couche d’infrastructure (acces a la base, SMTP, etc.).
