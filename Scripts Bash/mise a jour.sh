######################################################################
#! /bin/bash
# Auteur : Sadek SABIRI 
# version : 1.0 
# Description : script MàJ 
# A REVOIR TROP DUR
######################################################################

# Détecter la distribution
if [ -f /etc/debian_version ]; then
    PKG_MANAGER="apt-get"
    UPDATE_CMD="sudo $PKG_MANAGER update"
    UPGRADE_CMD="sudo $PKG_MANAGER upgrade -y"
elif [ -f /etc/redhat-release ]; then
    PKG_MANAGER="dnf"  # Pour les nouvelles versions, sinon remplacer par yum
    UPDATE_CMD="sudo $PKG_MANAGER check-update"
    UPGRADE_CMD="sudo $PKG_MANAGER upgrade -y"\else
    echo "Distribution non prise en charge."
    exit 1
fi

# Recherche des mises à jour
echo "Mise à jour de la liste des paquets..."
$UPDATE_CMD

# Installation des mises à jour
echo "Installation des mises à jour..."
$UPGRADE_CMD

echo "Mise à jour terminée."
