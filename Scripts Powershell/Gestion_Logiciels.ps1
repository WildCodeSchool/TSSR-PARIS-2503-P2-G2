######################################################################
# Auteur : Chahine MARZOUK 
# Version : 1.0
# Description : Script de gestion de logiciels via WinRM (PowerShell)
######################################################################

# Configuration de la cible (fixée ici à 172.16.20.20)
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
            param($logiciel)
            Write-Host "Tentative d'installation de $logiciel..."
            winget install --accept-source-agreements --accept-package-agreements $using:logiciel
        }
    }
    "2" {
        $logiciel = Read-Host "Nom du logiciel à désinstaller (ex: nom du package ou affichage exact)"
        Invoke-Command -ComputerName $hote -Credential $cred -ScriptBlock {
            param($logiciel)
            Write-Host "Tentative de désinstallation de $logiciel..."
            winget uninstall --accept-source-agreements $using:logiciel
        }
    }
    "3" {
        $chemin_script = Read-Host "Chemin absolu du script PowerShell (sur la machine distante, ex: C:\Scripts\test.ps1)"
        Invoke-Command -ComputerName $hote -Credential $cred -ScriptBlock {
            param($scriptPath)
            if (Test-Path $using:scriptPath) {
                Write-Host "Exécution de $scriptPath..."
                & $using:scriptPath
            } else {
                Write-Host "Fichier introuvable : $using:scriptPath"
            }
        }
    }
    default {
        Write-Host "Option invalide." -ForegroundColor Red
        exit
    }
}
