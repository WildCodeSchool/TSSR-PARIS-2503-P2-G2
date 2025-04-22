####################################################################################
# Autor : Pauline 
# Version : 1.0 
# Description : Script information utilisateur.ps1
# Etat : a tester
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
            Invoke-Command -HostName $ip -ScriptBlock {
                lastlog -u $using:user
            }
        }

        "2" {
            Write-Host "Date de dernière modification du mot de passe de l'utilisateur $user sur $ip"
            Invoke-Command -HostName $ip -ScriptBlock {
                chage -l $using:user | grep "Last password change"
            }
        }

        "3" {
            Write-Host "Liste des sessions ouvertes par l'utilisateur $user sur $ip"
            Invoke-Command -HostName $ip -ScriptBlock {
                who | grep $using:user
            }
        }

        "retour" {
            Write-Host "Retour au menu precedent"
        }

        default {
            Write-Host "Choix invalide. Merci de recommencer." -ForegroundColor Yellow
        }
    }
}

