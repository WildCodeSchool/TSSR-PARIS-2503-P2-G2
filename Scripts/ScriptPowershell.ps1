######################################################################
# Auteur : Pauline PRAK 
# Version : 1.0 
# Description : Script Global
# LOGS a ajouter  
######################################################################

# Initialisation des variables 
$DATE = Get-Date -Format "dd-MM-yyyy"
$HEURE = Get-Date -Format "HH:mm:ss"
$UTILISATEUR = $env:USERNAME
$FICHIERDUJOUR = "Info_${UTILISATEUR}_$DATE.log"
$LOGFILE = "C:\Windows\System32\LogFiles\$FICHIERDUJOUR"

# Verification et creation du fichier de log 
if (-not (Test-Path $LOGFILE)) {
    New-Item -Path $LOGFILE -ItemType File -Force
}

# Ajout de la premiere ligne 
Add-Content -Path $LOGFILE -Value "********************StartScript********************" 

# Initialisation de la variable de choix
$choix_menu_principal = ""

while ($choix_menu_principal -ne "4") {

    Write-Host "`n________________________ MENU PRINCIPAL ________________________`n"
    Write-Host "Gestion utilisateur___________________________________________: 1"
    Write-Host "Informations du systeme_______________________________________: 2"
    Write-Host "Maintenance du systeme________________________________________: 3"
    Write-Host "Quitter le script_____________________________________________: 4`n"
    
    $choix_menu_principal = Read-Host "Votre choix svp"

    switch ($choix_menu_principal) {
        "1" { 
            # Gestion utilisateurs et dossiers
            . "$(Get-Location)/Library/menu1_gestion_utilisateursetdossier.ps1"
        }
        "2" { 
            # Informations systeme
            . "$(Get-Location)/Library/menu2_informations_systeme.ps1"
        }
        "3" { 
            # Maintenance systeme
            . "$(Get-Location)/Library/menu3_maintenance_systeme.ps1"
        }
        "4" { 
            # Quitter 
            Write-Host "Fin du script"
            # Ajout de la derniere ligne 
            Add-Content -Path $LOGFILE -Value "********************EndScript********************"
            exit 0       
        }
        default {
            Write-Host "Choix invalide. Veuillez entrer un nombre entre 1 et 4."
        }
    }
}
