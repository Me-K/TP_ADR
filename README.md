# TP ADR – Systeme de gestion de bibliotheque

## Structure du depot

- `doc/adr/` : contient tous les Architecture Decision Records (ADR).
- `scripts/adr_check.sh` : script de validation du format des ADR.
- `.github/workflows/adr-check.yml` : workflow GitHub Actions pour lancer la validation a chaque push / pull request.
- `rapport.md` : reponses aux questions theoriques et analyse.

## Rédaction des ADR

- Un ADR = une decision d’architecture importante.
- Format impose :

  ```markdown
  # <Numero>. <Titre de la decision>

  ## Statut
  Accepte / Rejete / Obsolete / En discussion

  ## Contexte
  Description du probleme ou du besoin a adresser.

  ## Decision
  Solution choisie pour repondre au probleme.

  ## Alternatives envisagees
  Liste des alternatives et raisons de leur rejet.

  ## Consequences
  Impacts positifs et negatifs de la decision.
