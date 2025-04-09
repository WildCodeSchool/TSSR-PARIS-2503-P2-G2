#####################################################################
#! /bin/bash
# Auteur : Chahine Marzouk 
# version : 1.0 
# Description : Informations Port Parefeu
#####################################################################

echo "----- 🔍 Liste des ports ouverts (TCP/UDP) -----"

# Utilise ss s’il est disponible, sinon fallback sur netstat
if command -v ss >/dev/null 2>&1; then
  ss -tuln
elif command -v netstat >/dev/null 2>&1; then
  netstat -tuln
else
  echo "Erreur : ni ss ni netstat n’est disponible."
  exit 1
fi

echo ""
echo "----- 🔐 Statut du pare-feu (ufw) -----"

if command -v ufw >/dev/null 2>&1; then
  sudo ufw status verbose
else
  echo "ufw n’est pas installé sur cette machine."
fi
