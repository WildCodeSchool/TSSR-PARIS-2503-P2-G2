 Script de prise en main CLI
# Auteur : [Votre Nom]
# Date : $(date +%Y-%m-%d)

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Fonction pour afficher le menu
show_menu() {
    clear
    echo -e "${YELLOW}=== Script de Prise en Main CLI ===${NC}"
    echo -e "${GREEN}1. Afficher les informations système${NC}"
    echo -e "${GREEN}2. Vérifier l'espace disque${NC}"
    echo -e "${GREEN}3. Vérifier la mémoire disponible${NC}"
    echo -e "${GREEN}4. Lister les processus en cours${NC}"
    echo -e "${GREEN}5. Vérifier la connectivité réseau${NC}"
    echo -e "${GREEN}6. Mettre à jour le système (apt)${NC}"
    echo -e "${GREEN}7. Rechercher un fichier${NC}"
    echo -e "${GREEN}8. Analyser un répertoire${NC}"
    echo -e "${GREEN}9. Quitter${NC}"
    echo -e "${YELLOW}====================================${NC}"
}

# Fonction pour afficher les infos système
system_info() {
    echo -e "${BLUE}=== Informations Système ===${NC}"
    echo -e "Hostname: ${GREEN}$(hostname)${NC}"
    echo -e "Système d'exploitation: ${GREEN}$(lsb_release -d | cut -f2-)${NC}"
    echo -e "Kernel: ${GREEN}$(uname -r)${NC}"
    echo -e "Processeur: ${GREEN}$(lscpu | grep "Model name" | cut -d: -f2 | sed -e 's/^[ \t]*//')${NC}"
    echo -e "Uptime: ${GREEN}$(uptime -p)${NC}"
}

# Fonction pour vérifier l'espace disque
check_disk() {
    echo -e "${BLUE}=== Espace Disque ===${NC}"
    df -h | grep -v "tmpfs" | grep -v "udev"
}

# Fonction pour vérifier la mémoire
check_memory() {
    echo -e "${BLUE}=== Mémoire ===${NC}"
    free -h
}

# Fonction pour lister les processus
list_processes() {
    echo -e "${BLUE}=== Top 5 des processus par utilisation CPU ===${NC}"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
}

# Fonction pour vérifier le réseau
check_network() {
    echo -e "${BLUE}=== Connectivité Réseau ===${NC}"
    echo -e "Adresse IP: ${GREEN}$(hostname -I)${NC}"
    echo -e "Passerelle par défaut: ${GREEN}$(ip route | grep default | awk '{print $3}')${NC}"
    echo -e "\nTest de connectivité (8.8.8.8):"
    ping -c 3 8.8.8.8 | grep "packet"
}

# Fonction pour mettre à jour le système
update_system() {
    echo -e "${BLUE}=== Mise à jour du système ===${NC}"
    if [ -x "$(command -v apt)" ]; then
        sudo apt update && sudo apt upgrade -y
    else
        echo -e "${RED}Gestionnaire de paquets apt non trouvé.${NC}"
    fi
}

# Fonction pour rechercher un fichier
search_file() {
    read -p "Entrez le nom du fichier à rechercher: " filename
    read -p "Entrez le répertoire de recherche (par défaut /): " directory
    directory=${directory:-/}
    echo -e "${BLUE}=== Résultats de la recherche pour '$filename' dans '$directory' ===${NC}"
    sudo find "$directory" -name "$filename" 2>/dev/null
}

# Fonction pour analyser un répertoire
analyze_dir() {
    read -p "Entrez le chemin du répertoire à analyser: " dirpath
    if [ -d "$dirpath" ]; then
        echo -e "${BLUE}=== Analyse de $dirpath ===${NC}"
        echo -e "Taille: ${GREEN}$(du -sh "$dirpath" | awk '{print $1}')${NC}"
        echo -e "Nombre de fichiers: ${GREEN}$(find "$dirpath" -type f | wc -l)${NC}"
        echo -e "Nombre de sous-répertoires: ${GREEN}$(find "$dirpath" -type d | wc -l)${NC}"
        echo -e "\n5 plus gros fichiers:"
        find "$dirpath" -type f -exec du -h {} + 2>/dev/null | sort -rh | head -n 5
    else
        echo -e "${RED}Le répertoire $dirpath n'existe pas.${NC}"
    fi
}

# Boucle principale
while true; do
    show_menu
    read -p "Choisissez une option
