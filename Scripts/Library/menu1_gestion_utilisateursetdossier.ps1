######################################################################
# Version : 1.0 
# Description : Menu 1 : gestion utilisateur et dossier
# LOGS a finir  
######################################################################

Write-Host "______________________ GESTION UTILISATEURS ET DOSSIERS ______________________"
Write-Host "Gestion des utilisateurs                                                  : 1"
Write-Host "Gestion des groupes                                                       : 2"
Write-Host "Informations des utilisateurs                                             : 3"
Write-Host "Gestion des repertoires                                                   : 4"
Write-Host "Gestion droits et permissions                                             : 5"
Write-Host "Retour menu precedent                                                     : 6"

# Lire une premiere fois le choix
$choix = Read-Host "Votre choix"

while ($choix -ne "6") {
    switch ($choix) {
        "1" { 
            # Gestion des utilisateurs
            . "$(Get-Location)/Library/Gestion_Utilisateur.ps1"
        }
        "2" { 
            # Gestion des groupes
            . "$(Get-Location)/Library/Gestion_Groupe.ps1"
        }
        "3" { 
            # Informations des utilisateurs
            . "$(Get-Location)/Library/Informations_Utilisateur.ps1"
        }
        "4" { 
            # Gestion des repertoires
            . "$(Get-Location)/Library/Gestion_repertoire.ps1"
        }
        "5" { 
            # Gestion des droits et permissions
            . "$(Get-Location)/Library/Gestion_DroitsPermission.ps1"
        }
        default {
            Write-Host "Choix invalide. Veuillez entrer un nombre entre 1 et 6."
        }
    }

    Write-Host "`n------------------------ MENU ------------------------"
    Write-Host "1 : Gestion des utilisateurs"
    Write-Host "2 : Gestion des groupes"
    Write-Host "3 : Informations des utilisateurs"
    Write-Host "4 : Gestion des repertoires"
    Write-Host "5 : Gestion droits et permissions"
    Write-Host "6 : Retour menu precedent"
    $choix = Read-Host "Votre choix"
}

Write-Host "Retour au menu principal"
