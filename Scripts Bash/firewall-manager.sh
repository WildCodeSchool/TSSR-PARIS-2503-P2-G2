#!/bin/bash
# ======================================================
# Script: Gestion_Parefeu.sh
# Description: Gestionnaire de pare-feu iptables simple via SSH
# Author: Sadek
# Date: $(date +%Y-%m-%d)
# Version: 1.1
# OK SSH ATTENTION A PAS ACTIVER LE PAREFEU POUR TESTER OU CA TUE LA CO SSH - Commande pour débugger : sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
# ======================================================

# Variables configurables
IPTABLES="/sbin/iptables"
SSH_PORT="22"
HTTP_PORT="80"
HTTPS_PORT="443"
ALLOWED_PORTS=("$SSH_PORT" "$HTTP_PORT" "$HTTPS_PORT" "53") # SSH, HTTP, HTTPS, DNS
INTERFACE="eth0"

# Demander les informations d'accès à la machine distante
read -p "Adresse IP ou nom d'hôte de la machine distante : " client
read -p "Nom d'utilisateur SSH : " remote_user

# Fonction pour activer le pare-feu
enable_firewall() {
    echo "[+] Activation du pare-feu avec les règles de base..."

    ssh -t "$remote_user@$client" "
    sudo $IPTABLES -F
    sudo $IPTABLES -X
    sudo $IPTABLES -t nat -F
    sudo $IPTABLES -t nat -X
    sudo $IPTABLES -t mangle -F
    sudo $IPTABLES -t mangle -X

    sudo $IPTABLES -P INPUT DROP
    sudo $IPTABLES -P FORWARD DROP
    sudo $IPTABLES -P OUTPUT ACCEPT

    sudo $IPTABLES -A INPUT -i lo -j ACCEPT
    sudo $IPTABLES -A OUTPUT -o lo -j ACCEPT

    sudo $IPTABLES -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

    for port in \"${ALLOWED_PORTS[@]}\"; do
        sudo $IPTABLES -A INPUT -p tcp --dport \"\$port\" -j ACCEPT
        echo \"[+] Port TCP \$port ouvert\"
    done

    sudo $IPTABLES -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
    sudo $IPTABLES -A INPUT -j LOG --log-prefix \"IPTABLES-DROPPED: \" --log-level 4

    echo \"[+] Pare-feu activé avec succès\"
    "
}

# Fonction pour désactiver le pare-feu
disable_firewall() {
    echo "[+] Désactivation du pare-feu..."

    ssh -t "$remote_user@$client" "
    sudo $IPTABLES -F
    sudo $IPTABLES -X
    sudo $IPTABLES -t nat -F
    sudo $IPTABLES -t nat -X
    sudo $IPTABLES -t mangle -F
    sudo $IPTABLES -t mangle -X

    sudo $IPTABLES -P INPUT ACCEPT
    sudo $IPTABLES -P FORWARD ACCEPT
    sudo $IPTABLES -P OUTPUT ACCEPT

    echo \"[+] Pare-feu désactivé - TOUT LE TRAFIC EST AUTORISÉ\"
    "
}

# Fonction pour afficher le statut
show_status() {
    echo "[+] Statut actuel des règles iptables :"

    ssh -t "$remote_user@$client" "
    sudo $IPTABLES -L -n -v --line-numbers
    echo ''
    sudo $IPTABLES -t nat -L -n -v --line-numbers
    echo ''
    sudo $IPTABLES -t mangle -L -n -v --line-numbers
    "
}

# Boucle pour rester dans le menu après exécution
while true; do
    echo ""
    echo "1. Activer le pare-feu avec les règles"
    echo "2. Désactiver le pare-feu"
    echo "3. Afficher le statut des règles"
    echo "4. Quitter"
    read -p "Choisissez une option (1-4): " option

    case $option in
        1)
            enable_firewall
            ;;
        2)
            disable_firewall
            ;;
        3)
            show_status
            ;;
        4)
            echo "Au revoir!"
            exit 0
            ;;
        *)
            echo "Option invalide. Veuillez choisir entre 1 et 4."
            ;;
    esac
done
