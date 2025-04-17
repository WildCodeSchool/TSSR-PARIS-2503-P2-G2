######################################################################
# Auteur : Chahine MARZOUK 
# Version : 2.0
# Description : Script de gestion de logiciels via WinRM (PowerShell)
######################################################################

# Configuration de la cible
$hote = "172.16.20.20"

# Demande des informations d'identification
$cred = Get-Credential -Message "Entrez les identifiants pour la machine distante $hote"

# Menu des options
Write-Host "`nQue souhaitez-vous faire ?"
Write-Host "1. Installer un logiciel"
Write-Host "2. Désinstaller un logiciel"
Write-Host "3. Exécuter un script PowerShell sur la machine distante"
$choix = Read-Host "Entrez le numéro de l'option"

switch ($choix) {
    "1" {
        $logiciel = Read-Host "Nom du logiciel à installer (ex: nom du package avec winget ou MSI)"
        Invoke-Command -ComputerName $hote -Credential $cred -ScriptBlock {
            param($pkg)
            Write-Host "Tentative d'installation de $pkg..."
            winget install --accept-source-agreements --accept-package-agreements $pkg
        } -ArgumentList $logiciel
    }

    "2" {
        $logiciel = Read-Host "Nom du logiciel à désinstaller (ex: nom du package ou affichage exact)"
        Invoke-Command -ComputerName $hote -Credential $cred -ScriptBlock {
            param($pkg)
            Write-Host "Tentative de désinstallation de $pkg..."
            winget uninstall --accept-source-agreements $pkg
        } -ArgumentList $logiciel
    }

    "3" {
        $chemin_script = Read-Host "Chemin absolu du script PowerShell (sur la machine distante, ex: C:\Scripts\test.ps1)"
        Invoke-Command -ComputerName $hote -Credential $cred -ScriptBlock {
            param($scriptPath)
            if (Test-Path $scriptPath) {
                Write-Host "Exécution de $scriptPath..."
                & $scriptPath
            } else {
                Write-Host "Fichier introuvable : $scriptPath"
            }
        } -ArgumentList $chemin_script
    }

    default {
        Write-Host "Option invalide." -ForegroundColor Red
        exit
    }
}
