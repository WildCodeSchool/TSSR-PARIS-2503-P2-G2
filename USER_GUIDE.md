# Guide Utilisateur - Script Global de Gestion Système

## Description
Ce guide présente l'utilisation d'un ensemble de scripts Bash permettant la gestion d'une machine distante, incluant la gestion des utilisateurs, l'obtention d'informations système, et la maintenance.

Le script principal propose un menu permettant d'accéder à différentes fonctionnalités via des sous-menus.

## Fichiers Principaux

- `ScriptPrincipal.sh` : Script principal (point d'entrée).
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
chmod +x ScriptPrincipal.sh
```

Puis lancez :
```bash
./ScriptPrincipal.sh
```

## Remarques
- Le script principal vérifie l'existence du fichier log à chaque exécution.
- Tous les scripts secondaires sont situés dans le répertoire `Library/`.
- Utilisation de `sudo` est requise pour la création et la modification des logs.

## Auteurs
- Pauline PRAK - Version 1.0

## Version
- v1.0 - Scripts en développement, certaines sections de logs à compléter.

