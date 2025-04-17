####################################################################################
# Autor : Pauline 
# Version : 1.0 
# Description : Script Gestion_Groupe.ps1
# Etat : A tester
####################################################################################

Read-Host "------------------------------------------------------------"
Read-Host "Pour ajouter au groupe admin      : 1"
Read-Host "Pour ajouter à un groupe local    : 2"
Read-Host "Pour supprimer d'un groupe local  : 3"
Read-Host "Pour quitter                      : retour"
Read-Host "------------------------------------------------------------"
$Choix = Read-Host "Entrez votre choix"

while ("$choix" -ne "retour") {
    
    switch ($Choix) {
            "1" {# AJOUT A UN GROUPE D'ADMINISTRATION
                #Demander $User
                $User = Read-Host "Veuillez entrer le nom de l'utilisateur concerné" 
                # Vérifier si l'utilisateur existe
                if (Get-LocalUser -Name $User) 
                { #Si $User existe 
                    Add-LocalGroupMember -Group "Administrateurs" -Member $User
                    Write-Host "L'utilisateur $User a bien été ajouté à Administrateur" -ForegroundColor Green
                    # Commande retour menu précédent ???
                }
                else 
                {
                    Write-Host "L'utilisateur $User n'existe pas" -ForegroundColor Red
                    #Commande retour menu précédent ???
            }}

            "2" {# AJOUT A UN GROUPE LOCAL 
                #Demander $User
                $User = Read-Host "Veuillez entrer le nom de l'utilisateur concerné" 
                
                # Vérifier si l'utilisateur existe
                if (Get-LocalUser -Name $User) 
                { #Si $User existe 
                        # Demander groupe 
                                $Group = Read-Host "Veuillez entrer le groupe concerné" 
                                #Verifier si $Group Existe  
                                if (Get-LocalGroup -Name $Group) 
                                    { #Si $Group existe 
                                        Add-LocalGroupMember -Group $Group -Member $User  
                                        Write-Host "L'utilisateur $User a bien été ajouté à $Group" -ForegroundColor Green
                                        #Commande retour menu précédent ???
                                    }
                                    else 
                                    { #Si $Group n'existe pas 
                                        Write-Host "Le groupe $Group' n'existe pas." -ForegroundColor Red
                                        #Commande retour menu précédent ???
                                    }
                }
                else 
                { #Si $User n'existe pas 
                    Write-Host "L'utilisateur $User n'existe pas." -ForegroundColor Red
                    #Commande Retour menu précédent ???
                }}

            "3" {# SORTIE D'UN GROUPE LOCAL 

            #Demander $User
            $User = Read-Host "Veuillez entrer le nom de l'utilisateur concerné" 
            
            # Vérifier si l'utilisateur existe
            if (Get-LocalUser -Name $User) 
            { #Si $User existe 
                    # Demander groupe 
                            $Group = Read-Host "Veuillez entrer le groupe concerné" 
                            #Verifier si $Group Existe  
                            if (Get-LocalGroup -Name $Group) 
                                { #Si $Group existe 
                                    Remove-LocalGroupMember -Group $Group -Member $User  
                                    Write-Host "L'utilisateur $User a bien été supprimé de $Group" -ForegroundColor Green
                                    #Commande retour menu précédent ???
                                }
                                else 
                                { #Si $Group n'existe pas 
                                    Write-Host "Le groupe $Group' n'existe pas." -ForegroundColor Red
                                    #Commande retour menu précédent ???
                                }
            }
            else 
            { #Si $User n'existe pas 
                Write-Host "L'utilisateur $User n'existe pas." -ForegroundColor Red
                #Commande Retour menu précédent ??? 
            }}

            "4" {}

            Default {Write-Host "Entrée incorrecte, Veuillez entrer 1, 2 3 ou 4 svp"}
    }    
}