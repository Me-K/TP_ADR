#!/usr/bin/env bash

set -euo pipefail

ADR_DIR="../doc/adr"

echo "Verification des ADR dans ${ADR_DIR}..."

if [ ! -d "$ADR_DIR" ]; then
  echo "Erreur : le dossier ${ADR_DIR} n'existe pas."
  exit 1
fi

status=0

for file in "${ADR_DIR}"/*.md; do
  [ -e "$file" ] || continue

  echo "-> Verifie ${file}"

  # Verification des sections obligatoires
  grep -q "^# .*" "$file" || { echo "  [ECHEC] Titre principal (#) manquant"; status=1; }
  grep -q "^## Statut" "$file" || { echo "  [ECHEC] Section ##Statut manquante"; status=1; }
  grep -q "^## Contexte" "$file" || { echo "  [ECHEC] Section ##Contexte manquante"; status=1; }
  grep -q "^## Decision" "$file" || { echo "  [ECHEC] Section ##Decision manquante"; status=1; }
  grep -q "^## Alternatives envisagees" "$file" || { echo "  [ECHEC] Section ##Alternatives envisagees manquante"; status=1; }
  grep -q "^## Consequences" "$file" || { echo "  [ECHEC] Section ##Consequences manquante"; status=1; }

done

if [ "$status" -eq 0 ]; then
  echo "Tous les ADR respectent le template minimal."
else
  echo "Des ADR ne respectent pas le template. Voir les messages ci-dessus."
fi

exit "$status"
