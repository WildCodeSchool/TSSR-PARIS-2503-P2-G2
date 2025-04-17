######################################################################
#! /bin/bash
# Auteur : Sadek SABIRI 
# version : 1.0 
# Description : Script de création ou suppression d’un répertoire à distance via SSH 
# OK ssh
######################################################################

# Demander l'adresse IP ou le nom d'hôte de la machine distante
read -p "Adresse IP ou nom d'hôte de la machine distante : " client

# Demander le nom d'utilisateur SSH
read -p "Nom de l'utilisateur SSH : " remote_user

# Fonction pour créer un répertoire à distance
creer_repertoire() {
    local repertoire=$1
    ssh -t "$remote_user@$client" "if [ ! -d \"$repertoire\" ]; then mkdir -p \"$repertoire\"; echo \"Le répertoire $repertoire a été créé.\"; else echo \"Le répertoire $repertoire existe déjà.\"; fi"
}

# Fonction pour supprimer un répertoire à distance
supprimer_repertoire() {
    local repertoire=$1

    # Demander la confirmation localement avant d'exécuter la suppression à distance
    read -p "Voulez-vous vraiment supprimer $repertoire ? (o/n) " confirmation
    if [ "$confirmation" = "o" ] || [ "$confirmation" = "O" ]; then
        # Exécuter la suppression du répertoire à distance
        ssh -t "$remote_user@$client" "if [ -d \"$repertoire\" ]; then rm -rf \"$repertoire\"; echo \"Le répertoire $repertoire a été supprimé.\"; else echo \"Le répertoire $repertoire n'existe pas.\"; fi"
    else
        echo "Suppression annulée."
    fi
}

# Menu principal
while true; do
    echo ""
    echo "1. Créer un répertoire"
    echo "2. Supprimer un répertoire"
    echo "3. Quitter"
    read -p "Choisissez une option (1-3): " option

    case $option in
        1)
            read -p "Entrez le chemin du répertoire à créer: " chemin
            creer_repertoire "$chemin"
            ;;
        2)
            read -p "Entrez le chemin du répertoire à supprimer: " chemin
            supprimer_repertoire "$chemin"
            ;;
        3)
            echo "Au revoir!"
            exit 0
            ;;
        *)
            echo "Option invalide. Veuillez choisir entre 1 et 3."
            ;;
    esac
done
