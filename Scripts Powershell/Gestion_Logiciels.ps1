######################################################################
# Auteur : Chahine MARZOUK 
# Version : 1.0
# Description : Script de gestion de logiciels via SSH (PowerShell)
######################################################################

# Demande des informations de connexion
$hote = Read-Host "Adresse IP ou nom d'hôte de la machine distante"
$utilisateur = Read-Host "Nom d'utilisateur SSH distant"

# Menu des options
Write-Host "`nQue souhaitez-vous faire ?"
Write-Host "1. Installer un logiciel"
Write-Host "2. Désinstaller un logiciel"
Write-Host "3. Exécuter un script sur une machine distante"
$choix = Read-Host "Entrez le numéro de l'option"

switch ($choix) {
    "1" {
        $logiciel = Read-Host "Nom du logiciel à installer"
        ssh "$utilisateur@$hote" "sudo apt install -y $logiciel"
    }
    "2" {
        $logiciel = Read-Host "Nom du logiciel à désinstaller"
        ssh "$utilisateur@$hote" "sudo apt remove -y $logiciel"
    }
    "3" {
        $chemin_script = Read-Host "Chemin absolu du script à exécuter sur la machine distante"
        ssh "$utilisateur@$hote" "bash $chemin_script"
    }
    default {
        Write-Host "Option invalide." -ForegroundColor Red
        exit
    }
}
