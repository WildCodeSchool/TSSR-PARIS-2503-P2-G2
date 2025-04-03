
# DOCUMENTATION POUR LA MISE EN PLACE DU PROJET 

Cette documentation explique les étapes à suivre pour configurer un réseau entre un serveur Debian/client Ubuntu et un serveur Windows/client Windows.
Nous utiliserons Proxmox pour la virtualisation des machines.  


# PREREQUIS

Voici les prérequis concernant le matériel:
- L'hyperviseur Proxmox configuré avec 4 machines virtuelles : 
      - Debian 12 - Server 
      - Ubuntu 24 - Client 
      - Windows 22 - Server
      - Windows 11 - Client

Assurez-vous d'avoir accès aux comptes root sur Debian/Ubuntu et administrateur sur Windows Server/Windows 11.

Assurez-vous également d'avoir installé la commande `sudo`. Sinon suivez les étapes suivantes : 

1. **Passez en root** :
   ```bash
   su
   ```

2. **Installez sudo avec la commande suivante** :
   ```bash
   apt update && apt install sudo -y 
   ```

3. **Ajoutez un utilisateur au groupe `sudo`** pour lui permettre d'utiliser `sudo` :
   ```bash
   sudo usermod -aG sudo nom_utilisateur # Remplacez `nom_utilisateur` par le nom de l'utilisateur.


# CONFIGURATION 


## 1. Configuration du réseau interne entre Debian Server et Ubuntu Client

### Etape 1 : Installation des carte réseaux

Sur **Debian Server**, ajouter deux cartes réseaux :
   - Une pour le réseau interne avec le client
   - Une pour la connexion à Internet

Sur **Ubuntu Client**, ajouter une carte réseaux :
   - Une pour le réseau interne avec le server

### - Etape 2 : Configuration des cartes réseaux sur Debian Server

1. Ouvrir un terminal 

2. Chercher les noms des cartes réseaux, ils serviront pour la configuration dans les étapes suivantes 
   ```ip a
   ```

2. Créer un fichier de configuration réseau dans /etc/systemd/network 
   ```bash
   sudo nano /etc/systemd/network/interface.network
   ```

3. Ajouter les paramètres suivants dans le fichier :
   ```
   # Données de configuration de la première carte réseau pour le réseaux interne 
   [MATCH]
   Name=id  # Remplacer "id" par le nom de la première carte (type ens18)
   [Network]
   Address=192.168.X.X  # Remplacer avec l'adresse IP du réseau local

   # Données de configuration de la deuxième carte réseau pour internet 
   [MATCH]
   Name=id  # Remplacer "id" par le nom de la première carte (type ens19)
   [Network]
   Address=192.168.1.X  # Remplacer X par les deux derniers chiffres de la machine virtuelle 
   Gateway=192.168.1.254  # Passerelle par défaut
   ```

4. Enregistrez les modifications et quittez avec `Ctrl + X`, puis `Y` pour sauvegarder.

5. Redémarrez le service réseau :
   ```bash
   sudo systemctl restart systemd-networkd
   ```

### Étape 2 : Configuration de la carte réseau sur Ubuntu Client

1. Ouvrir un terminal 

2. Chercher le nom de la carte réseaux
   ```ip a
   ```

2. Créer un fichier de configuration réseau dans /etc/systemd/network 
   ```bash
   sudo nano /etc/systemd/network/interface.network
   ```

3. Ajouter les paramètres suivants dans le fichier :
   ```
   # Données de configuration de la carte réseau pour le réseaux interne 
   [MATCH]
   Name=id  # Remplacer "id" par le nom de la première carte (type ens18)
   [Network]
   Address=192.168.X.X  # Remplacer avec l'adresse IP du réseau local
   ```

4. Enregistrez les modifications et quittez avec `Ctrl + X`, puis `Y` pour sauvegarder.

5. Redémarrez le service réseau :
   ```bash
   sudo systemctl restart systemd-networkd
   ```

## 2. Configuration du réseau sur Windows Server et Windows 11 Client

### Étape 1 : Modifier les paramètres réseau sur Windows

1. Allez dans les **Paramètres Ethernet** :
   - Clic droit sur l'icône réseau dans la barre des tâches.
   - Sélectionnez **Paramètres réseau et Internet**.
   - Cliquez sur **Ethernet**, puis **Modifier les options d'adaptateur**.

2. Désactivez le **DHCP** en entrant l'adresse IP manuellement :
   - Cliquez droit sur la connexion Ethernet, puis sélectionnez **Propriétés**.
   - Sélectionnez **Protocole Internet version 4 (TCP/IPv4)** et cliquez sur **Propriétés**.
   - Choisissez **Utiliser l'adresse IP suivante** et entrez l'IP requise manuellement dans le champ approprié.

3. Après avoir configuré les adresses IP et résolu le problème de connexion Internet, la machine Windows devrait être capable d'accéder au réseau.

## 3. Vérification des connexions 

### Ping entre Debian Server et Ubuntu Client 
### Ping entre Debian Server et Google 
### Ping entre Windows Server et Windows 11 
### Ping entre Windows Server et Google

## 4. Conclusion

Une fois ces configurations terminées, vous avez un réseau configuré entre Debian Server/Ubuntu Client et Windows Server/Windows 11 Client. Ce projet peut être dupliqué en suivant les étapes ci-dessus et en ajustant les paramètres IP selon votre environnement.

Si vous rencontrez des problèmes de connexion, vérifiez la configuration IP sur chaque machine et assurez-vous que les interfaces réseau sont correctement configurées.
