####################################################################################
Autor : Pauline 
Version : 1.0 
Description : Script Powershell Gestion_Groupe.ps1
####################################################################################


# AJOUT A UN GROUPE D'ADMINISTRATION

#Demander $User
$User = Read-Host "Veuillez entrer le nom de l'utilisateur concerné" 

# Vérifier si l'utilisateur existe
if (Get-LocalUser -Name $User) 
{ #Si $User existe 
    Add-LocalGroupMember -Group "Administrateurs" -Member $User
    Write-Host "L'utilisateur $User a bien été ajouté à Administrateur" -ForegroundColor Green
    # Commande retour menu précédent 
}
else 
{
    Write-Host "L'utilisateur $User n'existe pas" -ForegroundColor Red
    #Commande retour menu précédent 
}





# AJOUT A UN GROUPE LOCAL 

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
                        #Commande retour menu précédent 
                    }
                    else 
                    { #Si $Group n'existe pas 
                        Write-Host "Le groupe $Group' n'existe pas." -ForegroundColor Red
                        #Commande retour menu précédent 
                    }
}
else 
{ #Si $User n'existe pas 
    Write-Host "L'utilisateur $User n'existe pas." -ForegroundColor Red
    #Commande Retour menu précédent 
}


# SORTIE D'UN GROUPE LOCAL 

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
                        #Commande retour menu précédent 
                    }
                    else 
                    { #Si $Group n'existe pas 
                        Write-Host "Le groupe $Group' n'existe pas." -ForegroundColor Red
                        #Commande retour menu précédent 
                    }
}
else 
{ #Si $User n'existe pas 
    Write-Host "L'utilisateur $User n'existe pas." -ForegroundColor Red
    #Commande Retour menu précédent 
}