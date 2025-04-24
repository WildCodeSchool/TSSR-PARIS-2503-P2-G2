######################################################################
# Version : 1.0 
# Description : Menu 3 : maintenance systeme
# LOGS a finir  
######################################################################

Write-Host "______________________ MAINTENANCE SYSTEME ______________________"
Write-Host "Information sur OS                                             : 1"
Write-Host "Mise a jour de l'OS                                            : 2"
Write-Host "Informations pare-feu                                          : 3"
Write-Host "Gestion pare-feu                                               : 4"
Write-Host "Gestion logiciels                                              : 5"
Write-Host "Arret, redemarrage et verrouillage                             : 6"
Write-Host "Gestion a distance                                             : 7"
Write-Host "Retour menu precedent                                          : 8"

# Lecture du choix utilisateur
$choix = Read-Host "Votre choix"

while ($choix -ne "8") {
    switch ($choix) {
        "1" {
            # Information OS
            . "$(Get-Location)/Library/Informations_OS.ps1"
        }
        "2" {
            # Mise a jour de l'OS
            . "$(Get-Location)/Library/MAJ.ps1"
        }
        "3" {
            # Informations pare-feu
            . "$(Get-Location)/Library/Informations_Port_Parefeu.ps1"
        }
        "4" {
            # Gestion pare-feu
            . "$(Get-Location)/Library/Gestion_Parefeu.ps1"
        }
        "5" {
            # Gestion logiciels
            . "$(Get-Location)/Library/Gestion_Logiciels.ps1"
        }
        "6" {
            # Arret, redemarrage et verrouillage
            . "$(Get-Location)/Library/Etat_Ordinateur.ps1"
        }
        "7" {
            # Gestion a distance
            . "$(Get-Location)/Library/Gestion_Distance.ps1"
        }
        default {
            Write-Host "Choix invalide. Veuillez entrer un chiffre entre 1 et 8."
        }
    }

    Write-Host "`n------------------------ MENU ------------------------"
    Write-Host "1 : Information sur OS"
    Write-Host "2 : Mise a jour de l'OS"
    Write-Host "3 : Informations pare-feu"
    Write-Host "4 : Gestion pare-feu"
    Write-Host "5 : Gestion logiciels"
    Write-Host "6 : Arret, redemarrage et verrouillage"
    Write-Host "7 : Gestion a distance"
    Write-Host "8 : Retour menu precedent"
    $choix = Read-Host "Votre choix"
}

Write-Host "Retour au menu principal"
