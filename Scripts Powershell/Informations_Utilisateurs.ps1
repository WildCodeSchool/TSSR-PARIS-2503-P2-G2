# Date de dernière connexion d’un utilisateur
$User = Read-Host "Veuillez entrer le nom d'utilisateur"    #Initialisation utilisateur via read-host 
$lastLogonEvent = Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4624; Data=$user} -MaxEvents 1  # Rechercher les événements de connexion pour $User
$lastLogonEvent.TimeCreated  # Afficher la date de la dernière connexion

ou 


$lastLogon = (Get-WinEvent -FilterHashtable @{Logname='Security';ID=528;Data=$user.Name} | 
Select-Object -First 1 | 
Sort-Object TimeCreated -Descending).TimeCreated
[PSCustomObject]@{
UserName    = $user.Name
LastLogon   = $lastLogon

Date de dernière modification du mot de passe


Liste des sessions ouvertes par l'utilisateur

Get-NetTCPConnection | Where-Object { $_.State -eq 'Established' } | Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State
Get-NetTCPConnection | Where-Object { $_.RemoteAddress -eq '192.168.1.100' -and $_.State -eq 'Established' }
 
OU DOIT ON METTRE $USER ? 