###################################
#!/bin/bash
#   version 0.0 
#   Auteur : Sadek SABIRI
#   description  : script etat ordinateur
###################################

# Affichage du menu
echo "Choisissez une option :"
echo "1) Arrêter l'ordinateur"
echo "2) Redémarrer l'ordinateur"
echo "3) Verrouiller la session"
echo "4) Quitter"

# Lecture de l'option choisie
read -p "Votre choix : " choix

case $choix in
    1)
        echo "Arrêt de l'ordinateur..."
        shutdown -h now
        ;;
    2)
        echo "Redémarrage de l'ordinateur..."
        reboot
        ;;
    3)
        echo "Verrouillage de la session..."
        gnome-screensaver-command -l 2>/dev/null || loginctl lock-session 2>/dev/null || echo "Commande de verrouillage non supportée."
        ;;
    4)
        echo "Quitter..."
        exit 0
        ;;
    *)
        echo "Option invalide. Veuillez entrer un chiffre entre 1 et 4."
        ;;
esac
