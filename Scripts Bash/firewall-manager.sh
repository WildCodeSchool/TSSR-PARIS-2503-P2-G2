======================================================
# Script: firewall-manager.sh
# Description: Gestionnaire de pare-feu iptables simple
#              Permet d'activer/désactiver le pare-feu
#              avec un ensemble de règles prédéfinies
# Author: sadek 
# Date: $(date +%Y-%m-%d)
# Version: 1.0
# Usage: ./firewall-manager.sh [start|stop|status]
# ======================================================

# Variables configurables
IPTABLES="/sbin/iptables"
SSH_PORT="22"
HTTP_PORT="80"
HTTPS_PORT="443"
ALLOWED_PORTS=("$SSH_PORT" "$HTTP_PORT" "$HTTPS_PORT" "53") # SSH, HTTP, HTTPS, DNS
INTERFACE="eth0"

# Fonction pour activer le pare-feu
enable_firewall() {
    echo "[+] Activation du pare-feu avec les règles de base..."
    
    # Réinitialiser les règles
    $IPTABLES -F
    $IPTABLES -X
    $IPTABLES -t nat -F
    $IPTABLES -t nat -X
    $IPTABLES -t mangle -F
    $IPTABLES -t mangle -X
    
    # Politiques par défaut (DROP tout le trafic)
    $IPTABLES -P INPUT DROP
    $IPTABLES -P FORWARD DROP
    $IPTABLES -P OUTPUT ACCEPT
    
    # Autoriser le trafic localhost
    $IPTABLES -A INPUT -i lo -j ACCEPT
    $IPTABLES -A OUTPUT -o lo -j ACCEPT
    
    # Autoriser les connexions établies
    $IPTABLES -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
    
    # Règles pour les ports autorisés
    for port in "${ALLOWED_PORTS[@]}"; do
        $IPTABLES -A INPUT -p tcp --dport "$port" -j ACCEPT
        echo "[+] Port TCP $port ouvert"
    done
    
    # Autoriser le ping (ICMP) - optionnel
    $IPTABLES -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
    
    # Journalisation des paquets rejetés (optionnel)
    $IPTABLES -A INPUT -j LOG --log-prefix "IPTABLES-DROPPED: " --log-level 4
    
    echo "[+] Pare-feu activé avec succès"
}

# Fonction pour désactiver le pare-feu
disable_firewall() {
    echo "[+] Désactivation du pare-feu..."
    
    # Réinitialiser toutes les règles et accepter tout le trafic
    $IPTABLES -F
    $IPTABLES -X
    $IPTABLES -t nat -F
    $IPTABLES -t nat -X
    $IPTABLES -t mangle -F
    $IPTABLES -t mangle -X
    
    $IPTABLES -P INPUT ACCEPT
    $IPTABLES -P FORWARD ACCEPT
    $IPTABLES -P OUTPUT ACCEPT
    
    echo "[+] Pare-feu désactivé - TOUT LE TRAFIC EST AUTORISÉ"
}

# Fonction pour afficher le statut
show_status() {
    echo "[+] Statut actuel des règles iptables:"
    $IPTABLES -L -n -v --line-numbers
    echo ""
    $IPTABLES -t nat -L -n -v --line-numbers
    echo ""
    $IPTABLES -t mangle -L -n -v --line-numbers
}

# Vérification des privilèges root
if [ "$(id -u)" -ne 0 ]; then
    echo "Erreur: Ce script doit être exécuté en tant que root" >&2
    exit 1
fi

# Gestion des arguments
case "$1" in
    start|enable)
        enable_firewall
        ;;
    stop|disable)
        disable_firewall
        ;;
    status)
        show_status
        ;;
    *)
        echo "Usage: $0 {start|stop|status}"
        echo "Options:"
        echo "  start, enable   - Active le pare-feu avec les règles"
        echo "  stop, disable   - Désactive complètement le pare-feu"
        echo "  status          - Affiche les règles actuelles"
        exit 1
esac

exit 0
