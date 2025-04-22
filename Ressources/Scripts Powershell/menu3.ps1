######################################################################
# version : 1.0 
# Description : Menu 3 : maintenance systeme
# LOGS a finir  
######################################################################

Write-Host "______________________ MAINTENANCE SYSTEME ______________________"
Write-Host "Information sur OS                                             : 1"
Write-Host "Mise à jour de l'OS                                            : 2"
Write-Host "Informations pare-feu                                          : 3"
Write-Host "Gestion pare-feu                                               : 4"
Write-Host "Gestion logiciels                                              : 5"
Write-Host "Arret, redémarrage et verrouillage                             : 6"
Write-Host "Gestion à distance                                             : 7"
Write-Host "Retour menu précédent                                          : 8"
Read-Host "Votre choix : " choix

while ("$choix" != "8"){

        switch ("$choix"){
                "1"{ 
                #Information OS
                        source $(pwd)/Library/Informations_OS.ps1
                }
                "2"{ 
                #Mise à jour de l'OS
                        source $(pwd)/Library/MAJ.ps1
                }
                "3"{ 
                #Informations pare-feu
                        source $(pwd)/Library/Informations_Port_Parefeu.ps1
                } 
                "4"{ 
                #Gestion pare-feu
                        source $(pwd)/Library/Gestion_Parefeu.ps1
                }
                "5"{ 
                #Gestion logiciels
                        source $(pwd)/Library/Gestion_Logiciels.ps1
                }
                "6"{ 
                #Arret, redémarrage et verrouillage
                        source $(pwd)/Library/Etat_Ordinateur.ps1
                }
                "7"{ 
                #Gestion à distance
                        source $(pwd)/Library/Gestion_Distance.ps1
                } 
                "8"{ 
                #retour menu précédent
                        Write-Host "Retour au menu principal"
                        exit 0
                }
        }
}
