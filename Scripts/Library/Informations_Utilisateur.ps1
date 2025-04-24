####################################################################################
# Auteur : Pauline 
# Version : 1.1 
# Description : Script information utilisateur.ps1
# État : à tester
####################################################################################

# --- Demande de l'adresse IP de la machine distante ---
$ip = Read-Host "Entrez l'adresse IP de la machine distante"

# --- Demande de l'utilisateur cible ---
$user = Read-Host "Entrez le nom d'utilisateur"

# --- Boucle de menu principal ---
$choix = ""

while ($choix -ne "retour") {
    Write-Host "`n========= MENU PRINCIPAL ========="
    Write-Host "Pour voir la date de dernière connexion de l'utilisateur : 1"
    Write-Host "Pour voir la date de dernière modification du mot de passe de l'utilisateur : 2"
    Write-Host "Pour voir la liste des sessions ouvertes par l'utilisateur : 3"
    Write-Host "Pour revenir au menu precedent : retour"
    Write-Host "=================================="

    $choix = Read-Host "Votre choix"

    switch ($choix) {
        "1" {
            Write-Host "Date de dernière connexion de l'utilisateur $user sur $ip"
            Invoke-Command -ComputerName $ip -ScriptBlock {
                $user = $using:user
                # Commande pour récupérer la dernière connexion de l'utilisateur sur Windows
                $logonInfo = Get-WinEvent -LogName Security | Where-Object { $_.Message -like "*$user*" -and $_.Id -eq 4624 } | Select-Object -First 1
                if ($logonInfo) {
                    $logonTime = $logonInfo.TimeCreated
                    Write-Host "Dernière connexion : $logonTime"
                } else {
                    Write-Host "Aucune connexion trouvée pour l'utilisateur $user."
                }
            }
        }

        "2" {
            Write-Host "Date de dernière modification du mot de passe de l'utilisateur $user sur $ip"
            Invoke-Command -ComputerName $ip -ScriptBlock {
                $user = $using:user
                # Utilisation de Get-LocalUser pour récupérer la date de modification du mot de passe
                $userInfo = Get-LocalUser -Name $user
                if ($userInfo) {
                    Write-Host "Dernière modification du mot de passe : $($userInfo.PasswordLastSet)"
                } else {
                    Write-Host "L'utilisateur $user n'existe pas sur cette machine."
                }
            }
        }

        "3" {
            Write-Host "Liste des sessions ouvertes par l'utilisateur $user sur $ip"
            Invoke-Command -ComputerName $ip -ScriptBlock {
                $user = $using:user
                # Utilisation de query pour lister les sessions ouvertes
                $sessions = query user | Where-Object { $_ -like "*$user*" }
                if ($sessions) {
                    Write-Host "Sessions ouvertes par $user :"
                    $sessions
                } else {
                    Write-Host "Aucune session ouverte trouvée pour l'utilisateur $user."
                }
            }
        }

        "retour" {
            Write-Host "Retour au menu précédent"
        }

        default {
            Write-Host "Choix invalide. Merci de recommencer." -ForegroundColor Yellow
        }
    }
}
