# Guide Utilisateur - Script Global de Gestion Système

## Description
Ce guide présente l'utilisation d'un ensemble de scripts Bash ou Powershell permettant la gestion d'une machine distante, incluant la gestion des utilisateurs, l'obtention d'informations système, et la maintenance.

Le script principal propose un menu permettant d'accéder à différentes fonctionnalités via des sous-menus.

## Fichiers Principaux

- `ScriptBash.sh` : Script principal (point d'entrée).
- `Library/menu1_gestion_utilisateursetdossier.sh` : Menu 1 - Gestion des utilisateurs et dossiers.
- `Library/menu2_informations_systeme.sh` : Menu 2 - Informations système.
- `Library/menu3_maintenance_systeme.sh` : Menu 3 - Maintenance système.

## Structure Générale

### Menu Principal
```text
1 - Gestion utilisateur
2 - Informations du systeme
3 - Maintenance du systeme
4 - Quitter le script
```

## Fonctionnalites

### 1. Gestion utilisateur
Ce menu permet de :
- Ajouter, supprimer ou modifier des utilisateurs.
- Gérer les groupes.
- Visualiser les informations des utilisateurs.
- Créer ou supprimer des répertoires.
- Modifier les permissions d'accès.

### 2. Informations système
Permet d'obtenir :
- Les interfaces réseau et leurs configurations.
- Les informations matérielles.
- Les logs du système.
- Les applications installées et les utilisateurs locaux.

### 3. Maintenance système
Permet de :
- Obtenir les informations sur l'OS.
- Effectuer des mises à jour.
- Afficher et gérer les ports et pare-feu.
- Gérer les logiciels.
- Éteindre, redémarrer ou verrouiller l'ordinateur.
- Gérer le système à distance.

## Logs
Un fichier de log journalier est créé automatiquement dans `/var/log` avec les droits restreints (600). Le nom du fichier suit le format suivant :

```text
Info_<nom_machine>_<date>.log
```

Exemple : `Info_monpc_22-04-2025.log`

## Lancement du Script
Assurez-vous que les scripts sont exécutables :
```bash
chmod +x ScriptBash.sh
```

Puis lancez :
```bash
./ScriptBash.sh
```

Pour lancer le script sur Powershell, il suffit de remplacer Bash par Powershell et l'extension .sh par .ps1

## Utilisation du Script

Pour utiliser le script, il suffit d'indiquer son choix à chaque menu ou sous-menu. Des options de retour au menu précédent ou de fermeture du script sont disponibles. Voici un exemple concret d'utilisation du script pour une demande d'informations OS, catégorie Maintenance système, pour une machine Ubuntu connectée à distance : 

![Aperçu](https://github.com/user-attachments/assets/5e003e68-a338-42b1-9217-8794c878c0bc)

## Remarques
- Le script principal vérifie l'existence du fichier log à chaque exécution.
- Tous les scripts secondaires sont situés dans le répertoire `Library/`.
- Utilisation de `sudo` est requise pour la création et la modification des logs.

## Auteurs
- Pauline PRAK - Version 1.0

## Version
- v1.0 - Scripts en développement, certaines sections de logs à compléter.

