######################################################################
#! /bin/bash
# Auteur : Pauline PRAK
# version : 1.0 
# Description : script informations OS projet 2 
# manque  logs
######################################################################

# Demande de l'adresse IP de la machine distante
read -p "Adresse IP de la machine distante : " ip

# Demande du nom d'utilisateur SSH sur la machine Ubuntu
read -p "Nom d'utilisateur SSH sur la machine Ubuntu : " ssh_user

# Connexion SSH à la machine distante et récupération de la version de l'OS
ssh ${ssh_user}@${ip} << EOF
lsb_release -a
EOF

# Vérification du code de sortie de la commande SSH
if [ $? -eq 0 ]; then
    echo "La commande a réussi."
else
    echo "Erreur : Impossible de se connecter à la machine Ubuntu ou récupérer la version de l'OS."
fi
sleep 3 
source ./menu3_maintenance_systeme.sh 
