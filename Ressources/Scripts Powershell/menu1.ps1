######################################################################
# Auteur : Pauline PRAK 
# version : 1.0 
# Description : Menu 1 : gestion utilisateur et dossier
# LOGS a finir  
######################################################################

Write-Host "______________________ GESTION UTILISATEURS ET DOSSIER ______________________"
Write-Host "Gestion des utilisateurs                                                  : 1"
Write-Host "Gestion des utilisateurs                                                  : 1"
Write-Host "Gestion des groupes                                                       : 2"
Write-Host "Informations des utilisateurs                                             : 3"
Write-Host "Gestion répertoire                                                        : 4"
Write-Host "Gestion droits et permissions                                             : 5"
Write-Host "Retour menu précédent                                                     : 6"
Read-Host "Votre choix : " choix

while ("$choix" != "6"){
        switch ($choix){
                "1"{ 
                #Gestion des utilisateurs
                source $(pwd)/Library/Gestion_Utilisateur.ps1
                }
                "2"{ 
                #Gestion des groupes
                source $(pwd)/Library/Gestion_Groupe.ps1
                }
                "3"{ 
                #Informations des utilisateurs
                source $(pwd)/Library/Informations_Utilisateur.ps1
                }
                "4"{ 
                #Gestion des répertoires
                source $(pwd)/Library/Gestion_repertoire.ps1
                }
                "5"{ 
                #Gestion droits et permissions
                source $(pwd)/Library/Gestion_DroitsPermission.ps1
                }
                "6"{ 
                #retour menu précédent
                Write-Host "Retour au menu principal"
                }
        }
}
