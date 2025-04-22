#! /bin/bash
######################################################################
# Auteur : Pauline PRAK 
# version : 1.0 
# Description : Script Global
# LOGS a ajouter  
######################################################################



while ("$choix_menu_principal" != "4"){
    
        Write-Host "\n________________________ MENU PRINCIPAL ________________________\n"
        Write-Host "Gestion utilisateur___________________________________________: 1"
        Write-Host "Informations du système_______________________________________: 2"
        Write-Host "Maintenance du système________________________________________: 3"
        Write-Host "Quitter le script_____________________________________________: 4\n"
        $choix_menu_principal=Read-Host "Votre choix svp : "    

        switch ($choix_menu_principal) {
        "1" { 
        #Gestion utilisateurs et dossier
        source $(pwd)/Library/menu1_gestion_utilisateursetdossier.ps1        
        }
        "2" { 
        #Information système
        source $(pwd)/Library/menu2_informations_systeme.ps1
        }
        "3" { 
        #maintenance systeme
        source $(pwd)/Library/menu3_maintenance_systeme.ps1
        }
        "4" { 
        #Quitter 
            Write-Host "Fin du script"
            exit 0       
        }
        esac
done
