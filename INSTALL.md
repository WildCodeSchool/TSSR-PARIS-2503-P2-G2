
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


1. **Passer en root** :
   ```bash
   su
   ```


2. **Installer sudo avec la commande suivante** :
   ```bash
   apt update && apt install sudo -y 
   ```


3. **Ajouter un utilisateur au groupe `sudo`** pour lui permettre d'utiliser `sudo` :
   ```bash
   sudo usermod -aG sudo nom_utilisateur # Remplacez `nom_utilisateur` par le nom de l'utilisateur.



# CONFIGURATION RESEAUX    


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
   ```bash
   ip a
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

4. Enregistrer les modifications et quittez avec `Ctrl + X`, puis `Y` pour sauvegarder.

5. Redémarrer le service réseau :
   ```bash
   sudo systemctl restart systemd-networkd
   ```


### Étape 2 : Configuration de la carte réseau sur Ubuntu Client

1. Ouvrir un terminal 

2. Chercher le nom de la carte réseaux
   ```bash
   ip a
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

4. Enregistrer les modifications et quittez avec `Ctrl + X`, puis `Y` pour sauvegarder.

5. Redémarrer le service réseau :
   ```bash
   sudo systemctl restart systemd-networkd
   ```


## 2. Configuration du réseau sur Windows Server et Windows 11 Client


### Étape 1 : Modifier les paramètres réseau sur Windows

1. Aller dans les **Paramètres Ethernet** :
   - Clique-droit sur l'icône réseau dans la barre des tâches (1).
   - Sélectionner **Paramètres réseau et Internet** (2).
   - Cliquer sur **Ethernet** (3)
   - Puis **Modifier l'attribution d'adresse IP** (4).


![Configuration IP Win 11 - Capture 1](https://github.com/WildCodeSchool/TSSR-PARIS-2503-P2-G2/blob/main/Ressources/Configuration%20IP%20Client%20Win%2011%20-%20Capture%201.png)

![Configuration IP Win 11 - Capture 2](https://github.com/WildCodeSchool/TSSR-PARIS-2503-P2-G2/blob/main/Ressources/Configuration%20IP%20Client%20Win%2011%20-%20Capture%202.png)


2. Désactivez le **DHCP** et entrer l'adresse IP manuellement :
   - Modifier Automatique en **Manuel** (5).
   - Activer **IPv4** (6).
   - Entrer l'IP, le masque et éventuellement le DSN manuellement dans les champs appropriés (7).


![Configuration IP Win 11 - Capture 3](https://github.com/WildCodeSchool/TSSR-PARIS-2503-P2-G2/blob/main/Ressources/Configuration%20IP%20Client%20Win%2011%20-%20Capture%203.png)


3. Après avoir configuré les adresses IP et résolu le problème de connexion Internet, la machine Windows est capable d'accéder au réseau.


## 3. Vérification des connexions 

Selon le cas, entrer les lignes de commandes dans un terminal. 
S'il y a une réponse, alors la connexion est établie. 
Sinon, reprendre l'installation et vérifier les configurations 


### Ping entre Debian Server et Ubuntu Client 

```bash
ping (adresse IP Ubuntu Client) 
```


### Ping entre Ubuntu Client et Debian Server   

```bash
ping (adresse IP Debian Server) 
```


### Ping entre Debian Server et Google

```bash
ping google.com
```


### Ping entre Windows Server et Windows 11

```powershell 
ping (adresse IP Windows 11) 
```


### Ping entre Windows 11 et Windows Server

```powershell 
ping (adresse IP Windows Server) 
```


### Ping entre Windows Server et Google

```powershell 
ping google.com
```


## 4. Conclusion

Une fois ces configurations terminées, vous avez un réseau configuré entre Debian Server/Ubuntu Client et Windows Server/Windows 11 Client. 
Ce projet peut être dupliqué en suivant les étapes ci-dessus et en ajustant les paramètres IP selon votre environnement.

Si vous rencontrez des problèmes de connexion, vérifiez la configuration IP sur chaque machine et assurez-vous que les interfaces réseaux sont correctement configurées.


# LANCEMENT DES SCRIPTS SUR MACHINE CLIENT  

Under construction ... 
#WinRM machine a distance win
#SSH debian/ubuntu 
