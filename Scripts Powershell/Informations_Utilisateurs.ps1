# Date de dernière connexion d’un utilisateur
$User = Read-Host "Veuillez entrer le nom d'utilisateur"    #Initialisation utilisateur via read-host 
$lastLogonEvent = Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4624; Data=$user} -MaxEvents 1  # Rechercher les événements de connexion pour $User
$lastLogonEvent.TimeCreated  # Afficher la date de la dernière connexion



Date de dernière modification du mot de passe
Liste des sessions ouvertes par l'utilisateur
