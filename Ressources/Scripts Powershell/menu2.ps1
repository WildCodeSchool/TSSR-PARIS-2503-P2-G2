######################################################################
# version : 1.0 
# Description : Menu 2 : informations systeme
# LOGS a finir  
######################################################################

Write-Host "______________________ INFORMATIONS SYSTEME ______________________"
Write-Host "Informations Interfaces                                        : 1"
Write-Host "Informations Matériel                                          : 2"
Write-Host "Informations Logs                                              : 3"
Write-Host "Informations Applications et Utilisateurs Locaux               : 4"
Write-Host "Retour menu précédent                                          : 5"
Read-Host -p "Votre choix : " choix

while ("$choix" != "5"){
switch ("$choix"){
        "1"{ 
        #Informations Interfaces
        source $(pwd)/Library/Informations_Interfaces.ps1
        }
        "2"{ 
        #Informations Matériel
        source $(pwd)/Library/Informations_Materiels.ps1
        }
        "3"{ 
        #Informations Logs
        source $(pwd)/Library/Informations_Logs.ps1
        }
        "4"{
        #Informations Applications et Utilisateurs Locaux
        source $(pwd)/Library/Informations_Applications_Utilisateurs.ps1
        }
        "5"{ 
        #retour menu précédent 
        Write-Host "Retour au menu principal"
        }
  }
}
