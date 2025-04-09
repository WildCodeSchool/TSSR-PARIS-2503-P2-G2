#####################################################################
#! /bin/bash
# Auteur : Chahine Marzouk 
# version : 1.0 
# Description : Informations Logs
#####################################################################

LOG_FILE="log_evt.log"

if [[ ! -f "$LOG_FILE" ]]; then
  echo "Erreur : le fichier $LOG_FILE est introuvable."
  exit 1
fi

echo "=== Analyse de $LOG_FILE ==="
echo "1. Rechercher les événements pour un utilisateur"
echo "2. Rechercher les événements pour un ordinateur"
read -p "Choisissez une option (1 ou 2) : " choix

case $choix in
  1)
    read -p "Entrez le nom de l'utilisateur : " utilisateur
    echo ""
    echo "📄 Événements pour l'utilisateur '$utilisateur' :"
    grep -i "$utilisateur" "$LOG_FILE"
    ;;
  2)
    read -p "Entrez le nom de l'ordinateur : " ordinateur
    echo ""
    echo "📄 Événements pour l'ordinateur '$ordinateur' :"
    grep -i "$ordinateur" "$LOG_FILE"
    ;;
  *)
    echo "Option invalide. Veuillez choisir 1 ou 2."
    exit 1
    ;;
esac
