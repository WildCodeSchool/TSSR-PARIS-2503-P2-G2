######################################################################
# Auteur : Chahine MARZOUK
# Version : 2.0
# Description : Script d’analyse de logs locaux en PowerShell
######################################################################

# Encodage UTF-8 pour la console
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Chemin vers le fichier log
$logPath = "log_evt.log"

# Vérification d'existence
if (-not (Test-Path $logPath)) {
    Write-Host "Erreur : le fichier $logPath est introuvable."
    exit 1
}

# Affichage du menu
function Show-Menu {
    Clear-Host
    Write-Host "===== Analyse du fichier de logs : $logPath ====="
    Write-Host "1) Rechercher les événements pour un utilisateur"
    Write-Host "2) Rechercher les événements pour un ordinateur"
    Write-Host "3) Quitter"
}

# Boucle de menu
do {
    Show-Menu
    $choix = Read-Host "Choisissez une option (1-3)"

    switch ($choix) {
        "1" {
            $utilisateur = Read-Host "Entrez le nom de l'utilisateur"
            Write-Host "`n>>> Événements contenant '$utilisateur' :"
            Select-String -Path $logPath -Pattern $utilisateur -SimpleMatch | ForEach-Object { $_.Line }
        }

        "2" {
            $ordinateur = Read-Host "Entrez le nom de l'ordinateur"
            Write-Host "`n>>> Événements contenant '$ordinateur' :"
            Select-String -Path $logPath -Pattern $ordinateur -SimpleMatch | ForEach-Object { $_.Line }
        }

        "3" {
            Write-Host "Fin du script."
            break
        }

        default {
            Write-Host "Option invalide. Veuillez choisir un nombre entre 1 et 3."
        }
    }

    if ($choix -ne "3") {
        Write-Host ""
        Read-Host "Appuyez sur Entrée pour revenir au menu..."
    }
} while ($choix -ne "3")
