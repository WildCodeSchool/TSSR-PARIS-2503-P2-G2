####################################################################################
# Autor : Pauline 
# Version : 1.0 
# Description : Script application et utilisateur.ps1
# Etat : a tester
####################################################################################

# --- Adresse IP de la machine distante ---
$ip = Read-Host "Entrez l'adresse IP de la machine Ubuntu distante"

# --- Boucle de menu principal ---
$choix = ""

while ($choix -ne "retour") {
    Write-Host "`n========= MENU PRINCIPAL ========="
    Write-Host "Pour voir la liste des applications installées : 1 "
    Write-Host "Pour voir la liste des paquets installés : 2"
    Write-Host "Pour voir la liste des utilisateurs locaux  : 3"
    Write-Host "Pour revenir au menu precedent : retour "

    $choix = Read-Host "Votre choix"

    switch ($choix) {
        "1" {
            Write-Host "`n📦 Liste des applications installées sur $ip"
            Invoke-Command -HostName $ip -ScriptBlock {
                dpkg -l
            }
        }

        "2" {
            Write-Host "`n🧩 Liste des paquets installés sur $ip"
            Invoke-Command -HostName $ip -ScriptBlock {
                apt list --installed
            }
        }

        "3" {
            Write-Host "`n👤 Liste des utilisateurs locaux sur $ip"
            Invoke-Command -HostName $ip -ScriptBlock {
                awk -F: '{ print $1 }' /etc/passwd
            }
        }

        "retour" {
            Write-Host "Retour menu precedent"
        }

        default {
            Write-Host "Choix invalide. Merci de recommencer." -ForegroundColor Yellow
        }
    }
}

