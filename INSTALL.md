
# Documentation pour la mise en place du projet

Cette documentation explique les étapes à suivre pour configurer un réseau via Proxmox. Elle couvre la configuration des cartes réseaux et des adresses IP sur Debian, Ubuntu, Windows Server et Windows 11. Elle est destinée à toute personne souhaitant dupliquer cette configuration.

## Prérequis

Avant de commencer, assurez-vous que vous avez :
- Un environnement virtuel Proxmox configuré avec Debian Server, Ubuntu Client, Windows Server et Windows 11 Client.
- Accès administrateur (root) sur Debian et Ubuntu.
- Accès administrateur sur Windows Server et Windows 11.

## 1. Configuration du réseau sur Debian Server et Ubuntu Client

### Étape 1 : Configuration de la carte réseau sur Debian

Sur **Debian Server**, nous avons configuré deux cartes réseau :
1. Une pour la connexion réseau avec le client.
2. Une pour la connexion à Internet.

#### Fichier de configuration pour la carte réseau

1. Ouvrez le fichier de configuration de la carte réseau avec `nano` :

   ```bash
   sudo nano /etc/systemd/network/interface.network
   ```

2. Ajoutez les paramètres suivants dans le fichier :

   ```ini
   [MATCH]
   Name=id  # Remplacez "id" par le nom de la carte trouvé avec la commande `ip a`, souvent "ens18"
   
   [Network]
   Address=192.168.X.X  # Remplacez avec l'adresse IP du réseau local ou d'internet
   ```

3. Pour la carte réseau dédiée à Internet, ajoutez une deuxième section `[MATCH]` pour configurer l'IP sur Proxmox, par exemple :

   ```ini
   [MATCH]
   Name=id_internet  # Nom de la carte réseau internet

   [Network]
   Address=192.168.1.X  # Remplacez X par les deux derniers chiffres de la machine virtuelle
   Gateway=192.168.1.254  # Passerelle par défaut
   ```

4. Enregistrez les modifications et quittez avec `Ctrl + X`, puis `Y` pour sauvegarder.

5. Redémarrez le service réseau :

   ```bash
   sudo systemctl restart systemd-networkd
   ```

### Étape 2 : Configuration du réseau sur Ubuntu Client

1. Ouvrez le fichier de configuration réseau sur Ubuntu pour la carte réseau liée au serveur Debian.

2. Configurez l'IP de manière statique, si nécessaire, pour que l'Ubuntu Client puisse se connecter au serveur Debian.

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

### Étape 2 : Installation de `sudo` sur Debian et Ubuntu

Pour installer `sudo` sur les machines Debian et Ubuntu, suivez les étapes suivantes :

1. **Vérifiez si `sudo` est installé** :

   ```bash
   sudo --version
   ```

2. Si `sudo` n'est pas installé, vous pouvez l'installer avec la commande suivante :

   ```bash
   sudo apt update
   sudo apt install sudo
   ```

3. **Ajoutez un utilisateur au groupe `sudo`** pour lui permettre d'utiliser `sudo` :

   ```bash
   sudo usermod -aG sudo nom_utilisateur
   ```

   Remplacez `nom_utilisateur` par le nom de l'utilisateur.

4. **Vérifiez si `sudo` fonctionne** en exécutant la commande suivante :

   ```bash
   sudo whoami
   ```

   La sortie devrait être `root`.

## Conclusion

Une fois ces configurations terminées, vous avez un réseau configuré entre Debian Server, Ubuntu Client, Windows Server et Windows 11 Client. Ce projet peut être dupliqué en suivant les étapes ci-dessus et en ajustant les paramètres IP selon votre environnement spécifique.

Si vous rencontrez des problèmes de connexion, vérifiez la configuration IP sur chaque machine et assurez-vous que les interfaces réseau sont correctement configurées.
