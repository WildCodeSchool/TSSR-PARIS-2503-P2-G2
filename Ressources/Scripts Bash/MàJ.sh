######################################################################
#! /bin/bash
# Auteur : Sadek SABIRI 
# version : 1.0 
# Description : script MàJ 
# OK SSH
######################################################################

# === Couleurs ===
GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"

# === Demander les infos ===
read -p "Adresse IP ou nom d'hôte du client Ubuntu : " CLIENT_IP
read -p "Nom d'utilisateur SSH du client : " CLIENT_USER

echo -e "${GREEN}➡ Connexion à $CLIENT_USER@$CLIENT_IP...${RESET}"

# === Bloc de commandes à exécuter sur le client ===
COMMANDS=$(cat << 'EOF'
echo " Client distant : $(hostname)"
echo " Mise à jour du système..."
sudo apt-get update && sudo apt-get upgrade -y
echo " Mise à jour terminée."
EOF
)

# === Connexion SSH et exécution ===
ssh -tt "$CLIENT_USER@$CLIENT_IP" "$COMMANDS"

# === Résultat ===
if [ $? -eq 0 ]; then
    echo -e "${GREEN} Mise à jour réussie sur $CLIENT_IP${RESET}"
else
    echo -e "${RED} Échec de la mise à jour sur $CLIENT_IP${RESET}"
fi
